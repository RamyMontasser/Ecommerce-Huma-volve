import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/service/home_service.dart';
import 'package:flutter/foundation.dart';

part 'home_cubit_state.dart';

class HomeCubitCubit extends Cubit<HomeCubitState> {
  final HomeService homeService;
  HomeCubitCubit({required this.homeService}) : super(HomeCubitInitial());

  Future<void> loadHomeContent() async {
    emit(GetCategoriesLoading());
    try {
      final categories = await homeService.getCategories();
      emit(GetCategoriesSuccess(categories: categories));
      final products = await homeService.getProducts();
      emit(GetProductsSuccess(products: products));
    } catch (e) {
      emit(GetCategoriesFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getCategories() async {
    emit(GetCategoriesLoading());
    try {
      final response = await homeService.getCategories();
      emit(GetCategoriesSuccess(categories: response));
    } catch (e) {
      emit(GetCategoriesFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getProducts({int? id}) async {
    emit(GetProductsLoading());
    try {
      final response = await homeService.getProducts(id: id);
      emit(GetProductsSuccess(products: response));
    } catch (e) {
      emit(GetProductsFailure(errorMessage: e.toString()));
    }
  }
}
