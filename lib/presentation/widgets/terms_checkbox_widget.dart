import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsCheckboxWidget extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const TermsCheckboxWidget({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  _TermsCheckboxWidgetState createState() => _TermsCheckboxWidgetState();
}

class _TermsCheckboxWidgetState extends State<TermsCheckboxWidget> {
  late bool checkValue;

  @override
  void initState() {
    super.initState();
    checkValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: checkValue,
          onChanged: (value) {
            setState(() {
              checkValue = value!;
            });
            widget.onChanged(checkValue);
          },
          side: BorderSide(color: Colors.grey), // Replace with `borderColor`
        ),
        RichText(
          text: TextSpan(
            text: 'Accept ',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              decoration: TextDecoration.none,
              color: Colors.black, // Replace with `textBlackColor`
            ),
            children: [
              TextSpan(
                text: 'Terms and Conditions',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  fontSize: 14,
                  color: Colors.blue, // Replace with `mainColor`
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
