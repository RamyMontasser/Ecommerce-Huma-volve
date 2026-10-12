import 'package:ecommerce_app_huma_volve/core/constants/api_constants.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/models/product_model.dart';

class HomeService {
  final ApiClient apiClient;

  HomeService({required this.apiClient});

  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(
      ApiConstants.getCategoriesEndpoint,
      queryParameters: {'limit': 5},
    );
    final data = response.data as List;
    List<CategoryModel> categories = data
        .map((data) => CategoryModel.fromJson(data))
        .toList();
    return categories;
  }

  Future<List<ProductModel>> getProducts({int? id}) async {
    final response = await apiClient.dio.get(
      id == null
          ? 'products'
          : '${ApiConstants.getCategoriesEndpoint}/$id/products',
      queryParameters: {'limit': 100, 'offset': 0},
    );
    final data = response.data as List;
    List<ProductModel> products = data
        .map((data) => ProductModel.fromJson(data))
        .toList();
    return products;
  }
}
