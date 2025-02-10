import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';

Widget customBtn(
    {required context,
    required VoidCallback onTap,
    required String text,
    String? icons}) {
  final width = MediaQuery.sizeOf(context).width;
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: whiteColor,
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
