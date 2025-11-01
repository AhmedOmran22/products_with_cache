import 'package:cache_and_theme_task_mentorship/core/constants/end_points.dart';
import 'package:cache_and_theme_task_mentorship/core/services/api_service.dart';
import '../models/product_model.dart';

class ProductsRemoteDataSource {
  final ApiService apiService;

  ProductsRemoteDataSource({required this.apiService});

  Future<List<ProductModel>> getProducts() async {
    final response = await apiService.get(EndPoints.products);
    final List productsJson = response["products"];
    return productsJson.map((e) => ProductModel.fromJson(e)).toList();
  }
}
