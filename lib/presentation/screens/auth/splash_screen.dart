import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/core/config/routes.dart';
import 'package:oru_phones_assignment/core/utils/show_toast.dart';
import 'package:oru_phones_assignment/data/services/notifaction_services.dart';
import 'package:oru_phones_assignment/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:oru_phones_assignment/presentation/screens/auth/mobile_number_screen.dart';
import 'package:oru_phones_assignment/presentation/screens/auth/mobile_otp_screen.dart';
import 'package:oru_phones_assignment/presentation/screens/auth/name_screen.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(IsLoggedInEvent()); // Fetch auth state once
  }

  void _navigateToNextScreen(BuildContext context, AuthState state) async {
    if (state is IsLoggedInAuthSuccess) {
      if (state.userLoggedIn.isLoggedIn) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.homeScreen,
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.mobileNumberScreen,
          (route) => false,
        );
      }
    } else if (state is AuthFailure) {
      print('Auth error: ${state.error}');
      showToast(state.error);
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.mobileNumberScreen,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor, // Same color as native splash
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) => _navigateToNextScreen(context, state),
        child: Center(
          child: Lottie.asset(splash),
        ),
      ),
    );
  }
}
