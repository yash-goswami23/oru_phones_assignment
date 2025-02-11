import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';

Widget customBtn(
    {required context,
    required VoidCallback onTap,
    required String text,
    bool isLoading = false,
    String? icons,
    double borderRadius = 4,
    Color? textColor,
    Color? btnShadowColor,
    required Color btnColor}) {
  textColor ??= whiteColor;
  final width = MediaQuery.sizeOf(context).width;
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: btnColor,
        boxShadow: btnShadowColor != null
            ? [
                BoxShadow(
                  color: btnShadowColor.withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ]
            : null,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: isLoading
          ? SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: whiteColor,
                strokeWidth: 2,
              ))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
                SizedBox(
                  width: width / 60,
                ),
                if (icons != null)
                  SvgPicture.asset(
                    icons,
                  )
              ],
            ),
    ),
  );
}
