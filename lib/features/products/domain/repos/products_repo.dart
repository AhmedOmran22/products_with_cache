import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/product_model.dart';

abstract class ProductsRepo {
  Future<Either<Failure, List<ProductModel>>> getProducts({
    int skip = 0,
    int limit = 10,
  });

  Future<List<ProductModel>> getLocalProducts();
}
