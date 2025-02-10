import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_button.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  bool tremsValue = false;
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
              'SignUp to continue',
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
                      'Please Tell Us Your Name',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                    ),
                    Text(
                      ' *',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Name',
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
            customBtn(
              context: context,
              onTap: () {},
              text: 'Confirm Name',
              icons: arrow,
            ),
          ],
        ),
      ),
    );
  }
}
