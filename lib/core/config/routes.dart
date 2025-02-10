import 'package:flutter/material.dart';
import 'package:oru_phones_assignment/presentation/screens/auth/mobile_number_screen.dart';
import 'package:oru_phones_assignment/presentation/screens/auth/name_screen.dart';
import 'package:oru_phones_assignment/presentation/screens/auth/splash_screen.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/mobile_hamburger/mobile_hamburger.dart';

const String splashScreen = '/';
const String mobileOtpScreen = '/MobileOtpScreen';
const String nameScreen = '/NameScreen';
const String mobileNumberScreen = '/MobileNumberScreen';
const String mobileHamburgerScreen = '/mobileHamburgerScreen';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case mobileNumberScreen:
        return MaterialPageRoute(
          builder: (context) => const MobileNumberScreen(),
        );
      case nameScreen:
        return MaterialPageRoute(
          builder: (context) => const NameScreen(),
        );
      case mobileOtpScreen:
        return MaterialPageRoute(
          builder: (context) => const MobileNumberScreen(),
        );
      case mobileHamburgerScreen:
        return MaterialPageRoute(
          builder: (context) => const MobileHamburger(),
        );
    }
    return null;
  }
}
