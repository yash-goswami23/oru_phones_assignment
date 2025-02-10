import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';

TextField customTextField({
  String? hintText,
  String? prefex,
  TextEditingController? controller,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: prefex != null
          ? Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                prefex,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: textBlackColor,
                ),
              ),
            )
          : null,
      hintStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w400, fontSize: 16, color: borderColor),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );
}
