import 'package:cache_and_theme_task_mentorship/core/constants/end_points.dart';
import 'package:cache_and_theme_task_mentorship/core/services/api_service.dart';
import '../models/product_model.dart';

class ProductsRemoteDataSource {
  final ApiService apiService;

  ProductsRemoteDataSource({required this.apiService});

  Future<List<ProductModel>> getProducts({int skip = 0, int limit = 10}) async {
    final response = await apiService.get(
      EndPoints.products,
      queryParameters: {"skip": skip, "limit": limit},
    );
    final List productsJson = response["products"];
    return productsJson.map((e) => ProductModel.fromJson(e)).toList();
  }
}
