import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/core/config/routes.dart';
import 'package:oru_phones_assignment/core/utils/show_toast.dart';
import 'package:oru_phones_assignment/data/models/auth_models/user_logged_in_model.dart';
import 'package:oru_phones_assignment/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_button.dart';
import 'package:oru_phones_assignment/presentation/widgets/show_custom_bottom_sheet.dart';

class MobileHamburger extends StatefulWidget {
  const MobileHamburger({super.key});

  @override
  State<MobileHamburger> createState() => _MobileHamburgerState();
}

class _MobileHamburgerState extends State<MobileHamburger> {
  final List<Map<String, String>> cardItems = [
    {'icon': buy, 'title': 'How to Buy'},
    {'icon': money, 'title': 'How to Sell'},
    {'icon': openBook, 'title': 'Oru Guide'},
    {'icon': about, 'title': 'About Us'},
    {'icon': privacyPolicy, 'title': 'Privacy Policy'},
    {'icon': faq, 'title': 'FAQs'},
  ];
  String sec = '0:23';
  final ValueNotifier<int> _seconds = ValueNotifier<int>(30);
  final ValueNotifier<bool> _isResendEnabled = ValueNotifier<bool>(false);
  Timer? _timer;
  bool isLoggedin = false;
  UserLoggedIn? userLoggedIn;
  bool checkValue = false;
  String userOTP = '';
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final state = context.read<AuthBloc>().state;
    _startTimer();
    context.read<AuthBloc>().add(IsLoggedInEvent());
    if (state is IsLoggedInAuthSuccess) {
      userLoggedIn = state.userLoggedIn;
      isLoggedin = state.userLoggedIn.isLoggedIn;
    }
  }

  void _startTimer() {
    _seconds.value = 30;
    _isResendEnabled.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds.value > 0) {
        _seconds.value--;
      } else {
        _isResendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SendOtpAuthSuccess) {
              final number = state.otpResponse.dataObject!.mobileNumber
                  .replaceAll('91', '');
              showCustomBottomSheet(
                context: context,
                height: height,
                number: number,
                sec: _seconds.value.toString(),
                onTap: () {
                  // print('value userOTP : $userOTP, number : $number, num $num');
                  // // print('value number : $number, num $num');
                  context
                      .read<AuthBloc>()
                      .add(OtpValidateEvent('91', number, userOTP));
                },
                otpSubmit: (otp) {
                  userOTP = otp;
                  // print('userOTP on submit: $userOTP');
                },
                inputTitle: '',
                inputHint: '',
                title: 'Verify OTP',
                icon: arrow,
                isLoading: state is AuthLoading ? true : false,
                star: '*',
                showOtp: true,
                userOtpCode: userOTP,
                btnText: 'Verify OTP',
              );
            } else if (state is AuthFailure) {
              showToast(state.error);
            } else if (state is OtpValidateAuthSuccess) {
              context.read<AuthBloc>().add(IsLoggedInEvent());
              showCustomBottomSheet(
                  context: context,
                  height: height,
                  inputTitle: 'Enter Your Name',
                  title: 'Sign in to continue',
                  btnText: 'Confirm Name',
                  inputHint: 'Name',
                  controller: nameController,
                  isLoading: state is AuthLoading ? true : false,
                  onTap: () {
                    // print('value name is ${nameController.text}');
                    context
                        .read<AuthBloc>()
                        .add(UpdatedUserDataEvent(nameController.text.trim()));
                  });
            } else if (state is UserUpdatedAuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.homeScreen,
                (route) => false,
              );
            } else if (state is LogoutAuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.mobileNumberScreen,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                // Header Section
                Container(
                  color: greyColor,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(logoSvg, height: 40, width: 40),
                          GestureDetector(
                            onTap: () {
                              final cP = Navigator.canPop(context);
                              if (cP) {
                                Navigator.pop(context);
                              }
                              showToast('$cP');
                            },
                            child: SvgPicture.asset(cross,
                                color: blackColor, height: 24, width: 24),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      if (isLoggedin)
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            child: ClipOval(
                              child: Image.network(
                                  'https://www.headshotpro.com/avatar-results/random-1.webp'),
                            ),
                          ),
                          title: Text(
                            userLoggedIn!.user!.userName.isEmpty
                                ? 'John Doe'
                                : userLoggedIn!.user!.userName,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: blackColor,
                            ),
                          ),
                          subtitle: Text(
                            'Joined: ${userLoggedIn!.user!.createdDate}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: blackColor,
                            ),
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                    ],
                  ),
                ),

                // Body Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(height: height / 24),

                      // Login / Signup Button
                      if (!isLoggedin)
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return customBtn(
                              context: context,
                              onTap: () {
                                showCustomBottomSheet(
                                  context: context,
                                  height: height,
                                  controller: mobileController,
                                  isLoading:
                                      state is AuthLoading ? true : false,
                                  onTap: () {
                                    if (
                                        // checkValue &&
                                        mobileController.text.isNotEmpty) {
                                      context.read<AuthBloc>().add(SendOtpEvent(
                                          '91', mobileController.text.trim()));
                                    } else {
                                      showToast(checkValue
                                          ? 'Enter Mobile Number'
                                          : 'Check the Box');
                                    }
                                  },
                                  inputTitle: 'Enter Your Mobile Number',
                                  inputPrefex: '+91 ',
                                  inputHint: 'Mobile Number',
                                  title: 'Sign in to continue',
                                  keyboardType: TextInputType.number,
                                  showTrems: (value) =>
                                      setState(() => checkValue = value),
                                  tremsValue: checkValue,
                                  icon: arrow,
                                  btnText: 'Next',
                                );
                              },
                              borderRadius: 100,
                              text: 'Login/SignUp',
                              btnShadowColor: mainColor,
                              btnColor: mainColor,
                            );
                          },
                        ),

                      SizedBox(height: height / 80),

                      // Sell Your Phone Button
                      customBtn(
                        context: context,
                        borderRadius: 100,
                        textColor: textBlackColor,
                        onTap: () {},
                        btnShadowColor: yellowColor,
                        text: 'Sell Your Phone',
                        btnColor: yellowColor,
                      ),

                      SizedBox(height: height / 24),

                      // Logout Button
                      if (isLoggedin)
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: InkWell(
                            onTap: () {
                              context.read<AuthBloc>().add(LogoutEvent());
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(logout, height: 34, width: 34),
                                SizedBox(width: 20),
                                Text(
                                  'Logout',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: blackColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),

      // Bottom Grid Navigation
      bottomNavigationBar: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cardItems.length,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 14,
          mainAxisSpacing: 12,
          childAspectRatio: 1.8, // Adjusted aspect ratio
        ),
        itemBuilder: (context, index) {
          return bottomCardItem(
            icon: cardItems[index]['icon']!,
            title: cardItems[index]['title']!,
          );
        },
      ),
    );
  }

  // Bottom Card Item
  Container bottomCardItem({required String icon, required String title}) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon, height: 30, width: 30),
          SizedBox(height: 5),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: textBlackColor,
            ),
          ),
        ],
      ),
    );
  }
}
