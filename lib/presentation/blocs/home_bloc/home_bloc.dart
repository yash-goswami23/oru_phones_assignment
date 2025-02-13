import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oru_phones_assignment/data/models/home_models/brand_response.dart';
import 'package:oru_phones_assignment/data/models/home_models/faq_response.dart';
import 'package:oru_phones_assignment/data/models/home_models/product_reponse.dart';
import 'package:oru_phones_assignment/data/repositories/home_repository.dart';
import 'package:oru_phones_assignment/data/repositories/shared_prefs.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepo;
  final SharedPrefs _sharedPrefs;

  HomeBloc(this._homeRepo, this._sharedPrefs) : super(HomeInitial()) {
    on<FetchBrandsEvent>(_fetchBrandsEvent);
    on<FetchProductsEvent>(_fetchProductsEvent);
    on<FetchFAQsEvent>(_fetchFAQsEvent);
  }

  Future<void> _fetchBrandsEvent(
      FetchBrandsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final response = await _homeRepo.fetchBrands();
      final value = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final brandResponse = BrandResponse.fromJson(value);
        emit(BrandsHomeSuccess(brandResponse.dataObject));
      } else {
        emit(HomeFailure(value['error'] ?? "Failed to fetch brands"));
      }
    } catch (e) {
      emit(HomeFailure("Error fetching brands: ${e.toString()}"));
    }
  }

  Future<void> _fetchProductsEvent(
      FetchProductsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final session = await _sharedPrefs.fetch('session');

      if (session == null) {
        emit(HomeFailure("Session not found"));
        return;
      }

      final response = await _homeRepo.fetchProducts(session.toString());
      final value = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final productResponse = ProductReponse.fromJson(value);
        emit(ProductsHomeSuccess(productResponse.data.data));
      } else {
        emit(HomeFailure(value['error'] ?? "Failed to fetch products"));
      }
    } catch (e) {
      emit(HomeFailure("Error fetching products: ${e.toString()}"));
    }
  }

  Future<void> _fetchFAQsEvent(
      FetchFAQsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final response = await _homeRepo.fetchFAQ();
      final value = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final faqResponse = FaqResponse.fromJson(value);
        emit(FAQsHomeSuccess(faqResponse.faqs));
      } else {
        emit(HomeFailure(value['error'] ?? "Failed to fetch FAQs"));
      }
    } catch (e) {
      emit(HomeFailure("Error fetching FAQs: ${e.toString()}"));
    }
  }
}
