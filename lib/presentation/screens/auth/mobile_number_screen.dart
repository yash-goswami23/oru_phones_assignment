import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_button.dart';
import 'package:oru_phones_assignment/presentation/widgets/show_custom_bottom_sheet.dart';
import 'package:oru_phones_assignment/presentation/widgets/terms_checkbox_widget.dart';

class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({super.key});

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    String userOtpCode;
    String number = '+91-7587329682';
    String sec = '0:23';
    bool checkValue = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
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
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Mobile Number',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        '+91',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: textBlackColor,
                        ),
                      ),
                    ),
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: borderColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )
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
            customBtn(
              context: context,
              btnColor: mainColor,
              onTap: () {},
              text: 'Next',
              icons: arrow,
            ),
          ],
        ),
      ),
    );
  }
}
