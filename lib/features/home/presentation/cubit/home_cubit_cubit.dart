import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repo/home_repo.dart';
import 'package:flutter/foundation.dart';

part 'home_cubit_state.dart';

class HomeCubitCubit extends Cubit<HomeCubitState> {
  final HomeRepo homeRepo;
  HomeCubitCubit({required this.homeRepo}) : super(HomeCubitInitial());

  Future<void> loadHomeContent() async {
    emit(GetCategoriesLoading());
      final categories = await homeRepo.getCategories();
      
      final products = await homeRepo.getProducts(id: 0);
      categories.fold(
      (failure) => emit(GetCategoriesFailure(errorMessage: failure.errorMsg)),
      (categories) => emit(GetCategoriesSuccess(categories: categories)),
    );
      products.fold(
        (failure) => emit(GetProductsFailure(errorMessage: failure.errorMsg)),
        (products) => emit(GetProductsSuccess(products: products)),
      );
  }

  Future<void> getCategories() async {
    emit(GetCategoriesLoading());
    final categories = await homeRepo.getCategories();
    categories.fold(
      (failure) => emit(GetCategoriesFailure(errorMessage: failure.errorMsg)),
      (categories) => emit(GetCategoriesSuccess(categories: categories)),
    );
  }

  Future<void> getProducts({int? id}) async {
    emit(GetProductsLoading());
    final products = await homeRepo.getProducts(id: id);
    products.fold(
      (failure) => emit(GetProductsFailure(errorMessage: failure.errorMsg)),
      (products) => emit(GetProductsSuccess(products: products)),
    );
  }
}
