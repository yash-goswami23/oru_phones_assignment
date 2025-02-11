import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/core/config/routes.dart';
import 'package:oru_phones_assignment/core/utils/show_toast.dart';
import 'package:oru_phones_assignment/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_button.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_text_field.dart';
import 'package:oru_phones_assignment/presentation/widgets/show_custom_bottom_sheet.dart';
import 'package:oru_phones_assignment/presentation/widgets/terms_checkbox_widget.dart';

class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({super.key});

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  TextEditingController numberController = TextEditingController();
  String countryCode = '91';
  bool checkValue = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.mobileHamburgerScreen,
                (route) => false,
              );
            },
            child: SvgPicture.asset(cross),
          )
        ],
      ),
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment,
          children: [
            SizedBox(height: height / 20),
            // SizedBox(height: 48),
            Image.asset(logo),
            SizedBox(height: height / 15),
            // SizedBox(height: 60),
            Text(
              'Welcome',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 28, color: mainColor),
            ),
            SizedBox(height: height / 140),
            // SizedBox(height: 10),
            Text(
              'Sign in to continue',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textGreyColor,
              ),
            ),
            SizedBox(height: height / 9),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Enter Your Phone Number',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
                customTextField(
                  hintText: 'Mobile Number',
                  prefex: '+$countryCode',
                  controller: numberController,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            SizedBox(height: height / 9),
            TermsCheckboxWidget(
              initialValue: checkValue,
              onChanged: (value) => setState(() {
                checkValue = value;
              }),
            ),
            SizedBox(height: height / 180),
            // SizedBox(height: 100),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is SendOtpAuthSuccess) {
                  Navigator.pushNamed(context, Routes.mobileOtpScreen);
                } else if (state is AuthFailure) {
                  showToast(state.error);
                }
              },
              builder: (context, state) {
                return customBtn(
                  context: context,
                  btnColor: mainColor,
                  isLoading: state is AuthLoading ? true : false,
                  onTap: () {
                    if (checkValue && numberController.text.isNotEmpty
                        // && numberController.text.length > 9
                        ) {
                      context.read<AuthBloc>().add(SendOtpEvent(
                          countryCode, numberController.text.trim()));
                    } else {
                      if (!checkValue) {
                        showToast('Check the Box');
                      } else {
                        showToast('Enter the Mobile Number');
                      }
                    }
                  },
                  text: 'Next',
                  icons: arrow,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
