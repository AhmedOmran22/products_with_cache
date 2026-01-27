import 'package:cache_and_theme_task_mentorship/core/services/local_data_base_service.dart';

import '../models/product_model.dart';

class ProductsLocalDataSource {
  final LocalDataBaseService localDataBaseService;

  ProductsLocalDataSource({required this.localDataBaseService});
  Future<List<ProductModel>> getProducts({int skip = 0, int limit = 10}) async {
    final productsList = await localDataBaseService.getData<ProductModel>(
      "cached_products",
    );
    if (productsList.isEmpty) return [];
    
    final endIndex = skip + limit;
    if (skip >= productsList.length) return [];
    
    return productsList.sublist(
      skip,
      endIndex > productsList.length ? productsList.length : endIndex,
    );
  }

  Future<void> saveProductsToCache({required List<ProductModel> products, bool clear = false}) async {
    if (clear) {
      await localDataBaseService.saveData('cached_products', products);
    } else {
      // Avoid duplicates when adding to cache
      final existingProducts = await localDataBaseService.getData<ProductModel>('cached_products');
      final existingIds = existingProducts.map((e) => e.id).toSet();
      final newProducts = products.where((p) => !existingIds.contains(p.id)).toList();
      
      if (newProducts.isNotEmpty) {
        await localDataBaseService.addData('cached_products', newProducts);
      }
    }
  }
}
