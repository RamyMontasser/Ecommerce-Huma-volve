import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repo/home_repo.dart';
import 'package:flutter/foundation.dart';

part 'home_cubit_state.dart';

class HomeCubitCubit extends Cubit<HomeCubitState> {
  static const int _pageSize = 10;

  final HomeRepo homeRepo;
  int _offset = 0;
  int _requestVersion = 0;
  int? _categoryId;
  bool _isLoadingMore = false;
  bool _hasMoreProducts = true;

  HomeCubitCubit({required this.homeRepo}) : super(HomeCubitInitial());

  Future<void> loadHomeContent() async {
    emit(GetCategoriesLoading());

    final categories = await homeRepo.getCategories();
    categories.fold(
      (failure) => emit(GetCategoriesFailure(errorMessage: failure.errorMsg)),
      (categories) => emit(GetCategoriesSuccess(categories: categories)),
    );

    await getProducts();
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
    final requestVersion = ++_requestVersion;
    _categoryId = id;
    _offset = 0;
    _hasMoreProducts = true;
    _isLoadingMore = false;

    emit(GetProductsLoading());
    final products = await homeRepo.getProducts(
      id: id,
      limit: _pageSize,
      offset: _offset,
    );
    if (requestVersion != _requestVersion) return;

    products.fold(
      (failure) => emit(GetProductsFailure(errorMessage: failure.errorMsg)),
      (products) {
        _offset = products.length;
        _hasMoreProducts = products.length == _pageSize;
        emit(GetProductsSuccess(products: products));
      },
    );
  }

  Future<void> loadMoreProducts() async {
    if (_isLoadingMore || !_hasMoreProducts || state is! GetProductsSuccess) {
      return;
    }

    final currentState = state as GetProductsSuccess;
    final requestVersion = _requestVersion;
    _isLoadingMore = true;
    emit(currentState.copyWith(isLoadingMore: true));

    final result = await homeRepo.getProducts(
      id: _categoryId,
      limit: _pageSize,
      offset: _offset,
    );
    if (requestVersion != _requestVersion) return;

    result.fold(
      (failure) {
        _isLoadingMore = false;
        emit(currentState.copyWith(loadMoreError: failure.errorMsg));
      },
      (products) {
        _offset += products.length;
        _hasMoreProducts = products.length == _pageSize;
        _isLoadingMore = false;
        emit(
          GetProductsSuccess(products: [...currentState.products, ...products]),
        );
      },
    );
  }
}
