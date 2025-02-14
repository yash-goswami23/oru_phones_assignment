import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oru_phones_assignment/core/config/app_color.dart';
import 'package:oru_phones_assignment/core/config/assets_path.dart';
import 'package:oru_phones_assignment/core/utils/show_toast.dart';
import 'package:oru_phones_assignment/data/models/home_models/faq_response.dart';
import 'package:oru_phones_assignment/data/models/home_models/product_reponse.dart';
import 'package:oru_phones_assignment/presentation/blocs/home_bloc/home_bloc.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_widgets/home_product_card.dart';
import 'package:oru_phones_assignment/presentation/screens/mobile/home/home_widgets/home_footer_widgets.dart';
import 'package:oru_phones_assignment/presentation/widgets/custom_button.dart';

Widget buildBestDealsSection(bool isGuest, List<Product>? products) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0),
        child: Row(
          children: [
            Text(
              'Best deals',
              style: GoogleFonts.poppins(
                color: textGreyColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              ' in India',
              style: GoogleFonts.poppins(
                color: mainColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      Row(
        children: [
          filterAndSort(onTap: () {}, fisrtIcon: sort, name: 'Sort'),
          SizedBox(width: 8),
          filterAndSort(onTap: () {}, fisrtIcon: filters, name: 'filters'),
        ],
      ),
      SizedBox(height: 25),
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
            if (state is ProductsHomeSuccess) {
              products = state.products;
            }

            if (products != null) {
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products!.length + (products!.length ~/ 5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.62,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 14),
                itemBuilder: (context, index) {
                  if ((index + 1) % 5 == 0) {
                    List<String> adImages = [
                      sell,
                      compare,
                    ];
                    String selectedImage =
                        adImages[Random().nextInt(2)]; // Random selection

                    return Image.asset(
                      selectedImage,
                      fit: BoxFit.cover,
                      height: 100,
                    );
                  } else {
                    int productIndex = index - (index ~/ 5);
                    final product = products![productIndex];

                    final ValueNotifier<bool> isFav =
                        ValueNotifier<bool>(false);
                    return ProductCard(
                      imageUrl: product.defaultImage!.fullImage,
                      title: product.marketingName.toString(),
                      storage: product.deviceStorage!,
                      condition: product.deviceCondition!,
                      price: double.parse(product.listingPrice!),
                      oldPrice: product.originalPrice,
                      discount: product.discountPercentage,
                      location: product.listingLocation!,
                      date: product.listingDate!,
                      isVerified: product.verified!,
                      onFavTap: () {
                        isFav.value = !isFav.value;
                      },
                      isFav: isFav,
                    );
                  }
                },
              );
            } else {
              context.read<HomeBloc>().add(FetchProductsEvent());
              return Center(
                child: CircularProgressIndicator(
                  color: blackColor,
                ),
              );
            }
          } else {
            if (state is HomeInitial ||
                state is BrandsHomeSuccess && !isGuest && products == null) {
              context.read<HomeBloc>().add(FetchProductsEvent());
            }
            return Center(child: CircularProgressIndicator(color: blackColor));
          }
        },
      ),
    ],
  );
}

GestureDetector filterAndSort(
    {required VoidCallback onTap,
    required String fisrtIcon,
    required String name}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(fisrtIcon),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: Text(
              name,
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          SvgPicture.asset(arrowDown),
        ],
      ),
    ),
  );
}
