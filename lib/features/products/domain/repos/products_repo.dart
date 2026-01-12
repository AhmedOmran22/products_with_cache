import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/product_entity.dart';

abstract class ProductsRepo {
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int skip = 0,
    int limit = 10,
  });

  Future<List<ProductEntity>> getLocalProducts();
}
