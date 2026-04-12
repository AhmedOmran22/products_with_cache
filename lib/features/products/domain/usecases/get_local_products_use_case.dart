import '../../data/models/product_model.dart';
import '../repos/products_repo.dart';

class GetLocalProductsUseCase {
  final ProductsRepo productsRepo;

  GetLocalProductsUseCase(this.productsRepo);

  Future<List<ProductModel>> call() {
    return productsRepo.getLocalProducts();
  }
}
