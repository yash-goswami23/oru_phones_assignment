import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/core/config/routes.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_widgets/home_footer_widgets.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_button.dart';

AppBar buildAppBar({required BuildContext context, required bool isGuest}) {
  return AppBar(
    scrolledUnderElevation: 0,
    title: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, Routes.mobileHamburgerScreen),
              child: SvgPicture.asset(menu)),
        ),
        SvgPicture.asset(logoSvg),
      ],
    ),
    backgroundColor: whiteColor,
    actions: [
      Text(
        'India',
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400, fontSize: 12, color: textBlackColor),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
        child: SvgPicture.asset(map),
      ),
      if (isGuest)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.5),
          child: SizedBox(
            height: 29,
            child: customBtn(
              context: context,
              onTap: () {},
              text: 'Login',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textColor: blackColor,
              btnColor: yellowColor,
            ),
          ),
        )
      else
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
    ],
  );
}

Container customSearchBar(
    {required TextEditingController controller, VoidCallback? onMicOpen}) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(11)),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
          child: SvgPicture.asset(
            search,
            height: 22,
            width: 22,
          ),
        ),
        Flexible(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Search phones with make, model...",
              border: InputBorder.none,
            ),
          ),
        ),
        Container(
          height: 18,
          decoration: BoxDecoration(border: Border.all(color: borderColor)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
          child: GestureDetector(
            onTap: onMicOpen,
            child: SvgPicture.asset(
              mic,
              height: 20,
              width: 20,
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildTagList(double height, List<String> tagItems) {
  return SizedBox(
    height: height / 20,
    child: ListView.builder(
      itemCount: tagItems.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => tabItem(
        text: tagItems[index],
        showTag: index == 6,
      ),
    ),
  );
}

Widget tabItem({
  required String text,
  bool showTag = false,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(top: 10, left: 10),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showTag)
            Container(
              margin: EdgeInsets.only(right: 4),
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  gradient: LinearGradient(colors: [
                    Color(0xff6565F1),
                    Color(0xffB152E9),
                    Color(0xffE9489D)
                  ])),
              child: Text(
                'new',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 6,
                    color: whiteColor),
              ),
            ),
          Text(
            text,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: textBlackColor),
          ),
        ],
      ),
    ),
  );
}
