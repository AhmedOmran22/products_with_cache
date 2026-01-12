import 'package:cache_and_theme_task_mentorship/core/errors/exception.dart';
import 'package:cache_and_theme_task_mentorship/features/products/data/data_source/product_local_data_source.dart';
import 'package:cache_and_theme_task_mentorship/features/products/domain/entities/product_entity.dart';
import 'package:cache_and_theme_task_mentorship/features/products/domain/repos/products_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../data_source/products_remote_data_source.dart';

class ProductsRepoImpl implements ProductsRepo {
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;
  ProductsRepoImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      // Try to fetch from API first
      final response = await remoteDataSource.getProducts(skip: skip, limit: limit);
      // Only save the first 10 products to cache
      if (skip == 0) {
        final productsToCache = response.take(10).toList();
        await localDataSource.saveProductsToCache(products: productsToCache);
      }
      return Right(response.map((e) => e.toEntity()).toList());
    } on CustomException catch (e) {
      return Left(ServerFailure(errMessage: e.message));
    }
  }

  @override
  Future<List<ProductEntity>> getLocalProducts() async {
    final cachedProducts = await localDataSource.getProducts();
    return cachedProducts.map((e) => e.toEntity()).toList();
  }
}
