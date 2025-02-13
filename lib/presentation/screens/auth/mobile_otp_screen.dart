import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/core/config/routes.dart';
import 'package:oru_phones_assignment/core/utils/show_toast.dart';
import 'package:oru_phones_assignment/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_button.dart';

class MobileOtpScreen extends StatefulWidget {
  const MobileOtpScreen({super.key});

  @override
  State<MobileOtpScreen> createState() => _MobileOtpScreenState();
}

class _MobileOtpScreenState extends State<MobileOtpScreen> {
  String userOtpCode = '';
  String number = '';
  String sec = '0:23';
  final ValueNotifier<int> _seconds = ValueNotifier<int>(30);
  final ValueNotifier<bool> _isResendEnabled = ValueNotifier<bool>(false);
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    final otpResponse = context.read<AuthBloc>().sendOtpResponse;
    number = otpResponse!.dataObject!.mobileNumber;
    print('number is : $number, otpREsponse :$otpResponse');
    _startTimer();
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
  void dispose() {
    _timer?.cancel();
    _seconds.dispose();
    _isResendEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is OtpValidateAuthSuccess) {
                if (state.otpValidate.user.userName.isEmpty) {
                  Navigator.pushNamed(context, Routes.nameScreen);
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.homeScreen, (route) => false);
                }
              } else if (state is AuthFailure) {
                showToast(state.error);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(height: height / 20),
                  // SizedBox(height: 48),
                  Image.asset(logo),
                  SizedBox(height: height / 15),
                  // SizedBox(height: 60),
                  Text(
                    'Verify Mobile No.',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: mainColor),
                  ),
                  SizedBox(height: height / 60),
                  // SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text:
                          'Please enter the 4 digital verification code sent\n',
                      children: [
                        TextSpan(text: 'to your mobile  number '),
                        TextSpan(
                          text: state is SendOtpAuthSuccess
                              ? state.otpResponse.dataObject?.mobileNumber
                              : '',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: textGreyColor,
                          ),
                        ),
                        TextSpan(text: ' via '),
                        TextSpan(
                            text: 'SMS',
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: textGreyColor,
                            )),
                      ],
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: textGreyColor,
                      ),
                    ),
                  ),
                  SizedBox(height: height / 9),
                  // SizedBox(height: 100),
                  OtpTextField(
                    numberOfFields: 4,
                    fieldHeight: 60,
                    fieldWidth: 60,
                    borderRadius: BorderRadius.circular(10),
                    margin: const EdgeInsets.symmetric(horizontal: 13),
                    enabledBorderColor: borderColor,
                    borderColor: borderColor,
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      print(code);
                      userOtpCode = code;
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      print(verificationCode);
                      userOtpCode = verificationCode;
                    }, // end onSubmit
                  ),
                  SizedBox(height: height / 15),
                  // SizedBox(height: 60),
                  Text(
                    'Didn’t receive OTP?',
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: textGreyColor),
                  ),
                  SizedBox(height: height / 160),
                  // SizedBox(height: 5),
                  ValueListenableBuilder<int>(
                    valueListenable: _seconds,
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () {
                          final num = number.replaceAll('91', '');
                          context.read<AuthBloc>().add(SendOtpEvent('91', num));
                          _startTimer();
                        },
                        child: RichText(
                          text: TextSpan(
                              text: 'Resend OTP',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  color: textBlackColor),
                              children: [
                                TextSpan(
                                  text: ' in $value Sec',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    decoration: TextDecoration.none,
                                    color: textBlackColor,
                                  ),
                                )
                              ]),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: height / 9),
                  // SizedBox(height: 100),
                  customBtn(
                    context: context,
                    isLoading: state is AuthLoading ? true : false,
                    onTap: () {
                      // if (state is SendOtpAuthSuccess) {
                      final num = number.replaceAll('91', '');
                      print('value num $num otp : $userOtpCode');
                      context
                          .read<AuthBloc>()
                          .add(OtpValidateEvent('91', num, userOtpCode));
                      // }
                    },
                    btnColor: mainColor,
                    text: 'Verify OTP',
                    // icons: arrow,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
