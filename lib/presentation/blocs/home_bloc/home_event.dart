part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class FetchBrandsEvent extends HomeEvent {}

class FetchProductsEvent extends HomeEvent {}

class FetchFAQsEvent extends HomeEvent {}
