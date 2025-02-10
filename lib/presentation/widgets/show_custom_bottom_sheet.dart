//Show Otp Bottom Sheet
// showCustomBottomSheet(
//     context: context,
//     height: height,
//     inputTitle: 'Please Tell Us Your Name',
//     inputHint: 'Name',
//     title: 'Verify OTP',
//     icon: arrow,
//     star: '*',
//     btnText: 'Verify OTP');

//show Mobile Number bottom sheet
// showCustomBottomSheet(
//     context: context,
//     height: height,
//     inputTitle: 'Enter Your Mobile Number',
//     inputPrefex: '+91 ',
//     inputHint: 'Mobile Number',
//     title: 'Sign in to continue',
//     showTrems: (value) {
//       setState(() {
//         checkValue = value;
//       });
//     },
//     tremsValue: checkValue,
//     icon: arrow,
//     btnText: 'Next');

//Show Name Bottom Sheet
// showCustomBottomSheet(
//     context: context,
//     height: height,
//     inputTitle: 'Please Tell Us Your Name',
//     inputHint: 'Name',
//     title: 'SigUp to continue',
//     icon: arrow,
//     star: '*',
//     btnText: 'Confirm Name');

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/core/config/routes.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_button.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_text_field.dart';
import 'package:oru_phones_assignment/presentation/widgets/terms_checkbox_widget.dart';

Future<dynamic> showCustomBottomSheet({
  required BuildContext context,
  required double height,
  required String inputTitle,
  required String title,
  required String btnText,
  required VoidCallback onTap,
  TextInputType? keyboardType,
  String? icon,
  String? star,
  String? inputHint,
  String? inputPrefex,
  ValueChanged<bool>? showTrems,
  bool? tremsValue,
  bool showOtp = false,
  String? number,
  String? userOtpCode,
  String? sec,
  TextEditingController? controller,
}) {
  return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: borderColor))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        if (showOtp)
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SvgPicture.asset(back),
                            ),
                          ),
                        Text(
                          title,
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: textBlackColor,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(cross))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: height / 25),
                    Column(
                      children: [
                        if (showOtp)
                          Column(
                            children: [
                              Text(
                                'Please enter the 4 digital verification code sent',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: textGreyColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'to your mobile  number ',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: textGreyColor,
                                    ),
                                  ),
                                  Text(
                                    ' number',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: textGreyColor,
                                    ),
                                  ),
                                  Text(
                                    ' via ',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: textGreyColor,
                                    ),
                                  ),
                                  Text(
                                    ' SMS',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: textGreyColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height / 25),
                              OtpTextField(
                                numberOfFields: 4,
                                fieldHeight: 60,
                                fieldWidth: 60,
                                borderRadius: BorderRadius.circular(10),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 13),
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
                              SizedBox(height: height / 40),
                              Text(
                                'Didn’t receive OTP?',
                                style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: textGreyColor),
                              ),
                              SizedBox(height: height / 180),
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
                            ],
                          )
                        else
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    inputTitle,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: blackColor,
                                    ),
                                  ),
                                  if (star != null)
                                    Text(
                                      star,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.red,
                                      ),
                                    ),
                                ],
                              ),
                              customTextField(
                                  hintText: inputHint,
                                  prefex: inputPrefex,
                                  keyboardType: keyboardType,
                                  controller: controller)
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: height / 120),
                    if (showTrems != null && tremsValue != null)
                      TermsCheckboxWidget(
                          initialValue: tremsValue!,
                          onChanged: (value) {
                            setState(() {
                              tremsValue = value;
                            });
                          })
                    else
                      SizedBox(
                        height: height / 28,
                      ),
                    customBtn(
                      context: context,
                      onTap: onTap,
                      btnColor: mainColor,
                      text: btnText,
                      icons: icon,
                    ),
                    SizedBox(height: height / 20),
                  ],
                ),
              )
            ],
          );
        },
      );
    },
  );
}
