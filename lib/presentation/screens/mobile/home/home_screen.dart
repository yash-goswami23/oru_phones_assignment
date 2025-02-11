import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/core/config/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGuest = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.mobileHamburgerScreen);
            },
            child: SvgPicture.asset(
              cross,
            ),
          )
        ],
      ),
      body: Center(
        child:
            isGuest ? Text('Home Screen - Guest Account') : Text('Home Screen'),
      ),
    );
  }
}
