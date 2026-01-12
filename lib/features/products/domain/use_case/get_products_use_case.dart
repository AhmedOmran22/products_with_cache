import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/product_entity.dart';
import '../repos/products_repo.dart';

class GetProductsUseCase {
  final ProductsRepo productsRepo;

  GetProductsUseCase(this.productsRepo);

  Future<Either<Failure, List<ProductEntity>>> call({int skip = 0, int limit = 10}) {
    return productsRepo.getProducts(skip: skip, limit: limit);
  }
}
