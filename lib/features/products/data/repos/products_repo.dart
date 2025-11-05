import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../models/product_model.dart';

abstract class ProductsRepo {
  Future<Either<Failure, List<ProductModel>>> getProducts({int skip, int limit});
}
