import 'package:flutter/material.dart';
import 'package:oru_phones_assignment/presentation/screens/auth/mobile_number_screen.dart';
import 'package:oru_phones_assignment/presentation/screens/auth/mobile_otp_screen.dart';
import 'package:oru_phones_assignment/presentation/screens/auth/name_screen.dart';
import 'package:oru_phones_assignment/presentation/screens/auth/splash_screen.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_screen.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/mobile_hamburger/mobile_hamburger.dart';

class Routes {
  static const String splashScreen = '/splash';
  static const String mobileNumberScreen = '/mobileNumber';
  static const String nameScreen = '/name';
  static const String mobileOtpScreen = '/mobileOtp';
  static const String mobileHamburgerScreen = '/mobileHamburger';
  static const String homeScreen = '/homeScreen';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return _fadeRoute(const SplashScreen(), settings);
      case mobileNumberScreen:
        return _fadeRoute(const MobileNumberScreen(), settings);
      case nameScreen:
        return _fadeRoute(const NameScreen(), settings);
      case mobileOtpScreen:
        return _fadeRoute(const MobileOtpScreen(), settings);
      case mobileHamburgerScreen:
        return _fadeRoute(const MobileHamburger(), settings);
      case homeScreen:
        return _fadeRoute(const HomeScreen(), settings);
      default:
        return _fadeRoute(const SplashScreen(), settings); // Default screen
    }
  }

  static PageRouteBuilder _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
