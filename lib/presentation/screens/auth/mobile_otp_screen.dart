import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_button.dart';

class MobileOtpScreen extends StatefulWidget {
  const MobileOtpScreen({super.key});

  @override
  State<MobileOtpScreen> createState() => _MobileOtpScreenState();
}

class _MobileOtpScreenState extends State<MobileOtpScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    String userOtpCode;
    String number = '+91-7587329682';
    String sec = '0:23';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
      ),
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: height / 20),
            // SizedBox(height: 48),
            Image.asset(logo),
            SizedBox(height: height / 15),
            // SizedBox(height: 60),
            Text(
              'Verify Mobile No.',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 28, color: mainColor),
            ),
            SizedBox(height: height / 60),
            // SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: 'Please enter the 4 digital verification code sent\n',
                children: [
                  TextSpan(text: 'to your mobile  number '),
                  TextSpan(
                    text: number,
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
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
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
            RichText(
              text: TextSpan(
                  text: 'Resend OTP',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      color: textBlackColor),
                  children: [
                    TextSpan(
                      text: ' in $sec Sec',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        color: textBlackColor,
                      ),
                    )
                  ]),
            ),
            SizedBox(height: height / 9),
            // SizedBox(height: 100),
            customBtn(
              context: context,
              onTap: () {},
              btnColor: mainColor,
              text: 'Verify OTP',
              // icons: arrow,
            ),
          ],
        ),
      ),
    );
  }
}
