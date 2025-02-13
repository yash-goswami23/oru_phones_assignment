part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class BrandsHomeSuccess extends HomeState {
  final List<Brand> brands;
  BrandsHomeSuccess(this.brands);
}

final class ProductsHomeSuccess extends HomeState {
  final List<Product> products;
  ProductsHomeSuccess(this.products);
}

final class HomeFailure extends HomeState {
  final String error;
  HomeFailure(this.error);
}

final class FAQsHomeSuccess extends HomeState {
  final List<Faq> faqs;
  FAQsHomeSuccess(this.faqs);
}
