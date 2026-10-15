import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/constants/api_constants.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repo/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final ApiClient apiClient;

  new({required this.apiClient});
  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try{
    final response = await apiClient.dio.get(
      ApiConstants.getCategoriesEndpoint,
      queryParameters: {'limit': 5},
    );
    final data = response.data as List;
    List<CategoryModel> categories = data
        .map((data) => CategoryModel.fromJson(data))
        .toList();
    return right (categories);
    } on DioException catch (e){
      return left(ServerFailure(errorMsg: e.message ?? 'Server Failure'));
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts({int? id,required int limit,
    required int offset,}) async {
    try {
     final response = await apiClient.dio.get(
        id == null
            ? 'products'
            : '${ApiConstants.getCategoriesEndpoint}/$id/products',
        queryParameters: {"limit": limit, "offset": offset},
      );
      final data = response.data as List;
      List<ProductModel> products = data
          .map((data) => ProductModel.fromJson(data))
          .toList();
      return right (products);
    } on DioException catch (e) {
      return left(ServerFailure(errorMsg: e.message ?? 'Server Failure'));
    } catch (e) {
      return left(ServerFailure(errorMsg: e.toString()));
    }
  }

}