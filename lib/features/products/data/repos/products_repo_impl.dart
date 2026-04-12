import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repos/products_repo.dart';
import '../data_source/product_local_data_source.dart';
import '../data_source/products_remote_data_source.dart';

class ProductsRepoImpl implements ProductsRepo {
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;

  ProductsRepoImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Stream<Either<Failure, List<ProductEntity>>> getProducts({
    int skip = 0,
    int limit = 10,
  }) async* {
    // ── Stale-while-revalidate (initial load only) ──────────────────────────
    // Yield whatever is in the cache immediately so the UI is never blank
    // while the network call is in flight. Pagination pages don't do this
    // because the existing list is already visible.
    if (skip == 0) {
      try {
        final cached = await localDataSource.getProducts(skip: 0, limit: limit);
        if (cached.isNotEmpty) {
          yield Right(cached.map((m) => m.toEntity()).toList());
        }
      } catch (_) {
        // Cache read failures are non-fatal here; remote is the source of truth.
      }
    }

    // ── Network fetch ────────────────────────────────────────────────────────
    try {
      final models = await remoteDataSource.getProducts(skip: skip, limit: limit);

      // Persist fresh data; clear the box only when refreshing from page 0.
      await localDataSource.saveProductsToCache(
        products: models,
        clear: skip == 0,
      );

      yield Right(models.map((m) => m.toEntity()).toList());
    } on CustomException catch (e) {
      yield Left(ServerFailure(errMessage: e.message));
    } catch (e) {
      yield Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
