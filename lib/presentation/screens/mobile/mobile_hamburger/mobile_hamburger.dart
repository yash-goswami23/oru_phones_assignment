import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_button.dart';
import 'package:oru_phones_assignment/presentation/widgets/show_custom_bottom_sheet.dart';

class MobileHamburger extends StatefulWidget {
  const MobileHamburger({super.key});

  @override
  State<MobileHamburger> createState() => _MobileHamburgerState();
}

class _MobileHamburgerState extends State<MobileHamburger> {
  final List<Map<String, String>> cardItems = [
    {'icon': buy, 'title': 'How to Buy'},
    {'icon': money, 'title': 'How to Sell'},
    {'icon': openBook, 'title': 'Oru Guide'},
    {'icon': about, 'title': 'About Us'},
    {'icon': privacyPolicy, 'title': 'Privacy Policy'},
    {'icon': faq, 'title': 'FAQs'},
  ];
  bool isLoggedin = false;
  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    TextEditingController mobileController = TextEditingController();
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: greyColor,
              margin: EdgeInsets.symmetric(vertical: 0),
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                        logoSvg,
                        height: 40,
                        width: 40,
                      ),
                      SvgPicture.asset(
                        cross,
                        color: blackColor,
                        height: 24,
                        width: 24,
                      )
                    ],
                  ),
                  if (isLoggedin)
                    ListTile(
                      title: Text(
                        'Rahul Sharma',
                        style: GoogleFonts.poppins(
                            letterSpacing: -1,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: blackColor),
                      ),
                      subtitle: Text(
                        'Joined: July 6 2024',
                        style: GoogleFonts.poppins(
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: textGreyColor),
                      ),
                      contentPadding: EdgeInsets.only(top: 24),
                      leading: SizedBox(
                          height: 44, width: 44, child: CircleAvatar()),
                    )
                  else
                    SizedBox.shrink(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: height / 24),
                  if (!isLoggedin)
                    customBtn(
                        context: context,
                        onTap: () {
                          showCustomBottomSheet(
                              context: context,
                              height: height,
                              controller: mobileController,
                              onTap: () {
                                showCustomBottomSheet(
                                    context: context,
                                    height: height,
                                    onTap: () {},
                                    inputTitle: 'Please Tell Us Your Name',
                                    inputHint: 'Name',
                                    title: 'Verify OTP',
                                    icon: arrow,
                                    star: '*',
                                    showOtp: true,
                                    btnText: 'Verify OTP');
                              },
                              inputTitle: 'Enter Your Mobile Number',
                              inputPrefex: '+91 ',
                              inputHint: 'Mobile Number',
                              title: 'Sign in to continue',
                              keyboardType: TextInputType.number,
                              showTrems: (value) {
                                setState(() {
                                  checkValue = value;
                                });
                              },
                              tremsValue: checkValue,
                              icon: arrow,
                              btnText: 'Next');
                        },
                        borderRadius: 100,
                        text: 'Login/SignUp',
                        btnShadowColor: mainColor,
                        btnColor: mainColor),
                  SizedBox(height: height / 80),
                  customBtn(
                      context: context,
                      borderRadius: 100,
                      textColor: textBlackColor,
                      onTap: () {},
                      btnShadowColor: yellowColor,
                      text: 'Sell Your Phone',
                      btnColor: yellowColor),
                  SizedBox(height: height / 24),
                  if (isLoggedin)
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            logout,
                            height: 34,
                            width: 34,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Logout',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GridView.builder(
        shrinkWrap: true,
        physics:
            NeverScrollableScrollPhysics(), // Prevents unnecessary scrolling
        itemCount: cardItems.length,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 14,
          mainAxisSpacing: 12,
          childAspectRatio: 1.6,
        ),
        itemBuilder: (context, index) {
          return bottomCardItem(
            icon: cardItems[index]['icon']!,
            title: cardItems[index]['title']!,
          );
        },
      ),
    );
  }

  Container bottomCardItem({required icon, required title}) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            height: 30,
            width: 30,
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: textBlackColor),
          )
        ],
      ),
    );
  }
}
