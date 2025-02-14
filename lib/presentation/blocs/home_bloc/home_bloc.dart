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

  List<Product>? products;
  List<Faq>? faqs;
  List<Brand>? brands;

  Future<void> _fetchBrandsEvent(
      FetchBrandsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      if (brands != null) {
        emit(BrandsHomeSuccess(brands!));
        return;
      }
      final response = await _homeRepo.fetchBrands();
      if (response.body == null || response.body.isEmpty) {
        emit(HomeFailure("Empty response from server"));
        return;
      }
      final value = jsonDecode(response.body);
      if (response.statusCode == 200 && value != null) {
        final brandResponse = BrandResponse.fromJson(value);

        if (brandResponse.dataObject != null) {
          brands = brandResponse.dataObject;
          emit(BrandsHomeSuccess(brandResponse.dataObject!));
        } else {
          emit(HomeFailure("Brand data is null or empty"));
        }
      } else {
        emit(HomeFailure(
            value?['error']?.toString() ?? "Failed to fetch brands"));
      }
    } catch (e) {
      emit(HomeFailure("Error fetching brands: ${e.toString()}"));
    }
  }

  Future<void> _fetchProductsEvent(
      FetchProductsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      if (products != null) {
        emit(ProductsHomeSuccess(products!));
      }
      final session = await _sharedPrefs.fetch('session');

      if (session == null || session.toString().isEmpty) {
        emit(HomeFailure("Session not found"));
        return;
      }

      final response = await _homeRepo.fetchProducts(session.toString());
      if (response.body == null || response.body.isEmpty) {
        emit(HomeFailure("Empty response from server"));
        return;
      }
      final value = jsonDecode(response.body);
      if (response.statusCode == 200 && value != null) {
        final productResponse = ProductReponse.fromJson(value);

        if (productResponse.data?.data != null) {
          products = productResponse.data.data;
          emit(ProductsHomeSuccess(productResponse.data.data));
        } else {
          emit(HomeFailure("Product data is null or empty"));
        }
      } else {
        emit(HomeFailure(
            value?['error']?.toString() ?? "Failed to fetch products"));
      }
    } catch (e) {
      emit(HomeFailure("Error fetching products: ${e.toString()}"));
    }
  }

  Future<void> _fetchFAQsEvent(
      FetchFAQsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      if (faqs != null) {
        emit(FAQsHomeSuccess(faqs!));
      }
      final response = await _homeRepo.fetchFAQ();
      if (response.body == null || response.body.isEmpty) {
        emit(HomeFailure("Empty response from server"));
        return;
      }
      final value = jsonDecode(response.body);
      if (response.statusCode == 200 && value != null) {
        final faqResponse = FaqResponse.fromJson(value);

        if (faqResponse.faqs != null) {
          faqs = faqResponse.faqs;
          emit(FAQsHomeSuccess(faqResponse.faqs!));
        } else {
          emit(HomeFailure("FAQ data is null or empty"));
        }
      } else {
        emit(
            HomeFailure(value?['error']?.toString() ?? "Failed to fetch FAQs"));
      }
    } catch (e) {
      emit(HomeFailure("Error fetching FAQs: ${e.toString()}"));
    }
  }
}
