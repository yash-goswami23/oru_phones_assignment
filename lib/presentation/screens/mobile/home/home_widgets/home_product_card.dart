import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String storage;
  final String condition;
  final double price;
  final int? oldPrice;
  final double? discount;
  final String location;
  final String date;
  final bool isVerified;
  final VoidCallback onFavTap;
  final ValueNotifier isFav;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.storage,
    required this.condition,
    required this.price,
    this.oldPrice,
    this.discount,
    required this.location,
    required this.date,
    required this.isVerified,
    required this.onFavTap,
    required this.isFav,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(11),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 0.1,
                  blurRadius: 4,
                  offset: Offset(0, -5))
            ]),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        imageUrl,
                        height: screenWidth * 0.35,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                      ),
                      child: Center(
                        child: Text(
                          "PRICE NEGOTIABLE",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: screenWidth * 0.03,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(11))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  softWrap: true,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: screenWidth * 0.04,
                                    color: blackColor,
                                  ),
                                ),
                                Text(
                                  "$storage • $condition",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: screenWidth * 0.03,
                                    color: textGreyColor,
                                  ),
                                ),
                                SizedBox(height: screenWidth * 0.01),
                                if (oldPrice != null)
                                  Flex(
                                    direction:
                                        // oldPrice!.toStringAsFixed(0).length > 4
                                        // ?
                                        Axis.vertical
                                    // : Axis.horizontal
                                    ,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "₹ ${price.toStringAsFixed(0)}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: screenWidth * 0.045,
                                        ),
                                      ),
                                      Center(
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          mainAxisSize: MainAxisSize.max,
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.center,
                                          // crossAxisAlignment:
                                          // CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: screenWidth * 0.01),
                                            if (oldPrice != null)
                                              if (oldPrice != 0)
                                                Text(
                                                  "₹ ${oldPrice!.toStringAsFixed(0)}",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize:
                                                        screenWidth * 0.020,
                                                    color: textGreyColor,
                                                  ),
                                                ),
                                            SizedBox(width: screenWidth * 0.01),
                                            if (discount != null)
                                              if (oldPrice != 0)
                                                Text(
                                                  "(${discount!.toInt()}% off)",
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        screenWidth * 0.025,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  Text(
                                    "₹ ${price.toStringAsFixed(0)}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth * 0.045,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // SizedBox(height: screenWidth * 0.01),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: greyColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 5))
                            ],
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10))),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                            vertical: screenWidth * 0.005),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                location,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: screenWidth * 0.025,
                                  color: textGreyColor,
                                ),
                              ),
                            ),
                            Text(
                              date,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: screenWidth * 0.025,
                                color: textGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isVerified)
              Positioned(
                top: screenWidth * 0.04,
                // left: screenWidth * 0.02,
                child: Image.asset(
                  verifiedTag,
                  width: screenWidth * 0.15,
                ),
              ),
            Positioned(
              top: screenWidth * 0.01,
              right: screenWidth * 0.01,
              child: ValueListenableBuilder(
                  valueListenable: isFav,
                  builder: (context, value, child) {
                    return IconButton(
                      onPressed: onFavTap,
                      icon: isFav.value
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border, color: Colors.white),
                      iconSize: screenWidth * 0.06,
                    );
                  }),
            ),
          ],
        ),
      );
    });
  }
}
