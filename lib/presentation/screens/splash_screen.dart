import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/core/config/routes.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile_number_screen.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile_otp_screen.dart';
import 'package:oru_phones_assignment/presentation/screens/name_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds before navigating to Home Screen
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
          context, mobileOtpScreen); // Change '/home' to your actual home route
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor, // Same color as native splash
      body: Center(
        child: Lottie.asset(splash),
      ),
    );
  }
}
