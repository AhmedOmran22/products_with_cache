import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/product_entity.dart';

abstract class ProductsRepo {
  /// Returns a Stream that yields at most two events for [skip] == 0:
  ///   1. Cached products immediately (stale-while-revalidate)
  ///   2. Fresh remote products (or a Failure if the network call fails)
  ///
  /// For [skip] > 0 (pagination) the stream yields exactly one event
  /// (the remote result, or a Failure — no cache-first for subsequent pages).
  Stream<Either<Failure, List<ProductEntity>>> getProducts({
    int skip = 0,
    int limit = 10,
  });
}
