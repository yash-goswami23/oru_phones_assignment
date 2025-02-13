import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';

GestureDetector sellFloatingBtn() {
  return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
            color: Color(0xff363636),
            border: Border.all(
                color: yellowColor,
                width: 4,
                strokeAlign: BorderSide.strokeAlignOutside),
            borderRadius: BorderRadius.circular(44)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sell',
              style: GoogleFonts.poppins(
                  color: yellowColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            Icon(
              Icons.add,
              color: yellowColor,
            )
          ],
        ),
      ));
}

Column socalMediaCard() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Text(
          'Or Share',
          style: GoogleFonts.poppins(
            color: textGreyColor,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(insta),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SvgPicture.asset(talegram),
            ),
            SvgPicture.asset(whatsApp),
            Padding(
              padding: const EdgeInsets.only(
                left: 32.0,
                // bottom: 30,
              ),
              child: SvgPicture.asset(x),
            ),
          ],
        ),
      )
    ],
  );
}

SizedBox inviteCard() {
  return SizedBox(
    height: 390,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
            height: 250,
            color: brownColor,
            padding: EdgeInsets.only(bottom: 110),
            alignment: Alignment.center,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Invite a Friend',
                    style: GoogleFonts.poppins(
                      color: whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ])),
        Positioned(
          top: 120,
          child: Container(
            decoration: BoxDecoration(
                color: whiteColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38, blurRadius: 4, spreadRadius: 4)
                ],
                borderRadius: BorderRadius.circular(40)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12),
              child: Column(
                children: [
                  Text(
                    'Invite a friend to ORUphones application.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                  Text(
                    'Tap to copy the respective download link to\nthe clipboard',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 19.0, bottom: 8),
                    child: Image.asset(playstoreDown),
                  ),
                  Image.asset(iosstoreDown)
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Column downloadAppCard() {
  return Column(
    children: [
      Container(
          height: 300,
          color: brownColor,
          padding: EdgeInsets.only(top: 22),
          alignment: Alignment.center,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Text(
                    'Download App',
                    style: GoogleFonts.poppins(
                      color: whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Image.asset(androidQR), Image.asset(iosQR)],
                  ),
                )
              ])),
    ],
  );
}

Container sendCard() {
  return Container(
    height: 222,
    color: yellowColor,
    alignment: Alignment.center,
    margin: EdgeInsets.only(top: 25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Get Notified About Our\nLatest Offers and Price Drops',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              color: textBlackColor, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Container(
          width: 280,
          margin: EdgeInsets.only(top: 25),
          padding: EdgeInsets.only(left: 21),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(74), color: whiteColor),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    hintText: "Enter your email here",
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: brownColor,
                  borderRadius: BorderRadius.circular(42),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                  child: Text(
                    'Send',
                    style: GoogleFonts.poppins(
                        color: whiteColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
