import 'dart:math';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/core/config/routes.dart';
import 'package:oru_phones_assignment/core/utils/show_toast.dart';
import 'package:oru_phones_assignment/data/models/home_models/brand_response.dart';
import 'package:oru_phones_assignment/data/models/home_models/faq_response.dart';
import 'package:oru_phones_assignment/data/models/home_models/product_reponse.dart';
import 'package:oru_phones_assignment/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:oru_phones_assignment/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_widgets/best_deals_widget.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_widgets/brands_section_widget.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_widgets/faq_widget.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_widgets/home_header.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_widgets/home_product_card.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_widgets/home_footer_widgets.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_widgets/whats_mind_card.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_button.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_text_field.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isGuest = false;
  final TextEditingController searchBarController = TextEditingController();
  final stt.SpeechToText speech = stt.SpeechToText();
  bool isListening = false;
  String text = "";
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  late ScrollController _scrollController;
  final ValueNotifier<bool> _isFabVisible = ValueNotifier(true);

  List<Brand>? brands;
  List<Product>? products;
  List<Faq>? faqs;

  final List<String> tagItems = [
    'Sell Used Phones',
    'Buy Used Phones',
    'Compare Prices',
    'My Profile',
    'My Listings',
    'Services',
    'Register your Store',
    'Get the App'
  ];

  final List<String> images = [
    banner1,
    banner2,
    banner3,
    banner4,
    banner5,
  ];

  Future<void> startListening() async {
    bool available = await speech.initialize(
      onStatus: (status) => print("Status: $status"),
      onError: (error) => print("Error: $error"),
    );

    if (available) {
      setState(() => isListening = true);
      speech.listen(onResult: (result) {
        setState(() => text = result.recognizedWords);
      });
    }
  }

  void stopListening() {
    setState(() => isListening = false);
    speech.stop();
  }

  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(IsLoggedInEvent());
    final state = context.read<AuthBloc>().state;
    if (state is IsLoggedInAuthSuccess) {
      isGuest = false;
    }
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _isFabVisible.value = false;
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _isFabVisible.value = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _isFabVisible.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: buildAppBar(context: context, isGuest: isGuest),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSearchBar(
                    controller: searchBarController,
                    onMicOpen: () {
                      if (isListening) {
                        stopListening();
                      } else {
                        startListening();
                      }
                    },
                  ),
                  buildTagList(height, tagItems),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: _buildImageSlider(),
                  ),
                  // _buildMindSection(),
                  WhatsMindCard(),
                  buildTopBrandsSection(isGuest: isGuest, brands: brands),
                  buildBestDealsSection(isGuest, products),
                ],
              ),
            ),
            buildFAQSection(isGuest: isGuest, faqs: faqs),
            sendCard(),
            downloadAppCard(),
            inviteCard(),
            socalMediaCard(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _isFabVisible,
        builder: (context, isVisible, child) {
          return AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: isVisible ? 1.0 : 0.0,
              child: sellFloatingBtn());
        },
      ),
    );
  }

  Widget _buildImageSlider() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) => _currentIndex.value = index,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(images[index], fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 5),
        ValueListenableBuilder<int>(
          valueListenable: _currentIndex,
          builder: (context, currentIndex, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                bool isActive = currentIndex == index;
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isActive ? borderColor : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor, width: 2),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
