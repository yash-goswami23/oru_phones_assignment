import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/core/utils/show_toast.dart';
import 'package:oru_phones_assignment/data/models/home_models/faq_response.dart';
import 'package:oru_phones_assignment/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_widgets/home_footer_widgets.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_button.dart';

Widget buildFAQSection({required bool isGuest, List<Faq>? faqs}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Frequently Asked Questions',
                style: GoogleFonts.poppins(
                  color: textGreyColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: textGreyColor, size: 20),
            ],
          ),
        ),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeFailure) {
              return Center(
                child: Text(
                  state.error.toString(),
                  style:
                      GoogleFonts.poppins(color: textBlackColor, fontSize: 22),
                ),
              );
            } else if (state is ProductsHomeSuccess ||
                state is BrandsHomeSuccess ||
                state is FAQsHomeSuccess) {
              if (state is FAQsHomeSuccess) {
                faqs = state.faqs;
              }
              if (faqs != null) {
                return Column(
                    children: faqs!.map((faq) {
                  final ValueNotifier<bool> _isExpanded =
                      ValueNotifier<bool>(false);
                  return FAQItem(
                    question: faq.question,
                    answer: faq.answer,
                    expandNotifier: _isExpanded,
                  );
                  // return fnqItem(
                  //     question: faq.question,
                  //     answer: faq.answer,
                  //     isExpanded: _isExpanded);
                }).toList());
              } else {
                context.read<HomeBloc>().add(FetchFAQsEvent());
                return Center(
                    child: CircularProgressIndicator(
                  color: blackColor,
                ));
              }
            } else {
              if (state is HomeInitial ||
                  state is BrandsHomeSuccess ||
                  state is ProductsHomeSuccess && !isGuest && faqs == null) {
                context.read<HomeBloc>().add(FetchFAQsEvent());
              }
              return Center();
            }
          },
        ),
      ],
    ),
  );
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;
  final ValueNotifier<bool> expandNotifier;

  const FAQItem({
    super.key,
    required this.question,
    required this.answer,
    required this.expandNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: expandNotifier,
      builder: (context, isExpanded, child) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                expandNotifier.value = !expandNotifier.value;
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 4,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(question,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    Icon(isExpanded ? Icons.close : Icons.add,
                        color: Colors.black),
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: isExpanded ? null : 0,
              child: isExpanded
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(answer,
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[800])),
                    )
                  : SizedBox(),
            ),
          ],
        );
      },
    );
  }
}
