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
  return Column(
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
                style: GoogleFonts.poppins(color: textBlackColor, fontSize: 22),
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
                return fnqItem(
                    question: faq.question,
                    answer: faq.answer,
                    isExpanded: _isExpanded);
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
  );
}

Widget fnqItem(
    {required String question,
    required String answer,
    required ValueNotifier isExpanded}) {
  return ValueListenableBuilder(
      valueListenable: isExpanded,
      builder: (context, value, child) {
        return ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text(
            question,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textBlackColor,
            ),
          ),
          onExpansionChanged: (expanded) => isExpanded.value = expanded,
          shape: Border.all(color: Colors.white),
          expandedAlignment: Alignment.centerLeft,
          trailing: Icon(isExpanded.value ? Icons.close : Icons.add),
          childrenPadding: EdgeInsets.zero,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  answer,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: textBlackColor,
                  ),
                ),
              ],
            ),
          ],
        );
      });
}
