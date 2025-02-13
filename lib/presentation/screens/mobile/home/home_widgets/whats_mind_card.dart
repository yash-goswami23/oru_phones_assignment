import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';

class WhatsMindCard extends StatelessWidget {
  WhatsMindCard({super.key});

  final List<Map<String, String>> menuItems = [
    {"icon": buyUsedPhones, "label": "Buy Used Phones"},
    {"icon": sellUsedPhones, "label": "Sell Used Phones"},
    {"icon": comparePrices, "label": "Compare Prices"},
    {"icon": myProfile, "label": "My Profile"},
    {"icon": myListings, "label": "My Listings"},
    {"icon": openStore, "label": "Open Store"},
    {"icon": services, "label": "Services"},
    {"icon": deviceHealth, "label": "Device Health Check"},
    {"icon": batteryHealth, "label": "Battery Health Check"},
    {"icon": iMeiVerification, "label": "IMEI Verification"},
    {"icon": deviceDetail, "label": "Device Details"},
    {"icon": dataWipe, "label": "Data Wipe"},
    {"icon": underWarranty, "label": "Under Warranty Phones"},
    {"icon": premiumPhones, "label": "Premium Phones"},
    {"icon": likeNewPhones, "label": "Like New Phones"},
    {"icon": refurbishedPhones, "label": "Refurbished Phones"},
    {"icon": verifiedPhones, "label": "Verified Phones"},
    {"icon": myNegotiations, "label": "My Negotiations"},
    {"icon": myFavourites, "label": "My Favourites"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [buildMindSection(), buildMenuItems()],
    );
  }

  Widget buildMindSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28.0),
      child: Text(
        'What’s on your mind?',
        style: GoogleFonts.poppins(
          color: textGreyColor,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget buildMenuItems() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: menuItems.map((item) {
          return Column(
            children: [
              Image.asset(item["icon"]!, width: 72, height: 72),
              SizedBox(height: 5),
              SizedBox(
                width: 80,
                child: Text(
                  item["label"]!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: blackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
