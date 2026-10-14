part of 'home_cubit_cubit.dart';

@immutable
sealed class HomeCubitState {}

final class HomeCubitInitial extends HomeCubitState {}
final class GetCategoriesSuccess extends HomeCubitState {
  final List<CategoryModel> categories;

  GetCategoriesSuccess({required this.categories});


}
final class GetCategoriesFailure extends HomeCubitState {
  final String errorMessage;

  GetCategoriesFailure({required this.errorMessage});
}
final class GetCategoriesLoading extends HomeCubitState {}


final class GetProductsSuccess extends HomeCubitState {
  final List<ProductModel> products;

  GetProductsSuccess({required this.products});
}
final class GetProductsFailure extends HomeCubitState {
    final String errorMessage;

  GetProductsFailure({required this.errorMessage});
}
final class GetProductsLoading extends HomeCubitState {}
