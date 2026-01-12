import 'package:cache_and_theme_task_mentorship/core/services/local_data_base_service.dart';

import '../models/product_model.dart';

class ProductsLocalDataSource {
  final LocalDataBaseService localDataBaseService;

  ProductsLocalDataSource({required this.localDataBaseService});
  Future<List<ProductModel>> getProducts({int skip = 0, int limit = 10}) async {
    final productsList = await localDataBaseService.getData<ProductModel>(
      "cached_products",
    );
    return productsList;
  }

  Future<void> saveProductsToCache({required List<ProductModel> products}) async {
    await localDataBaseService.saveData('cached_products', products);
  }
}
