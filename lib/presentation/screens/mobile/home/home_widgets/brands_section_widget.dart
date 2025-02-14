import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/core/utils/show_toast.dart';
import 'package:oru_phones_assignment/data/models/home_models/brand_response.dart';
import 'package:oru_phones_assignment/data/models/home_models/faq_response.dart';
import 'package:oru_phones_assignment/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_widgets/home_footer_widgets.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_button.dart';

Widget buildTopBrandsSection({required bool isGuest, List<Brand>? brands}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top brands',
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
          if (state is HomeInitial ||
              state is FAQsHomeSuccess ||
              state is ProductsHomeSuccess && !isGuest && brands == null) {
            context.read<HomeBloc>().add(FetchBrandsEvent());
          }
          if (state is BrandsHomeSuccess ||
              state is ProductsHomeSuccess ||
              state is FAQsHomeSuccess) {
            if (state is BrandsHomeSuccess) {
              brands = state.brands;
            }
            return SizedBox(
              height: 74,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  if (brands != null) {
                    if (index == 6) {
                      return brandItemCard(showVeiwAll: true);
                    } else {
                      return brandItemCard(brandImg: brands![index].imagePath);
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            );
          } else {
            return brandItemCard(
              showVeiwAll: true,
              onTap: () => context.read<HomeBloc>().add(FetchBrandsEvent()),
            );
          }
        },
      ),
    ],
  );
}

Widget brandItemCard(
    {String brandImg = '', VoidCallback? onTap, bool showVeiwAll = false}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(17),
      decoration: BoxDecoration(shape: BoxShape.circle, color: greyColor),
      child: showVeiwAll
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('View All',
                      style: GoogleFonts.poppins(
                          color: mainColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500)),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    arrow,
                    color: mainColor,
                    height: 12,
                  )
                ],
              ),
            )
          : Image.network(
              brandImg!,
              height: 55,
              width: 55,
            ),
    ),
  );
}
