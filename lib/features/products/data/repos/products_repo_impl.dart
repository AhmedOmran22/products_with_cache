import 'package:cache_and_theme_task_mentorship/core/errors/exception.dart';
import 'package:cache_and_theme_task_mentorship/features/products/data/data_source/product_local_data_source.dart';
import 'package:cache_and_theme_task_mentorship/features/products/data/repos/products_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../data_source/products_remote_data_source.dart';
import '../models/product_model.dart';

class ProductsRepoImpl implements ProductsRepo {
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;
  ProductsRepoImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts({
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      // Try to fetch from API first
      final response = await remoteDataSource.getProducts(skip: skip, limit: limit);
      // Only save the first 10 products to cache
      if (skip == 0) {
        final productsToCache = response.take(10).toList();
        localDataSource.saveProductsToCache(products: productsToCache);
      }
      return Right(response);
    } on CustomException catch (e) {
      // If API call fails, try to get from cache
      final cachedProducts = await localDataSource.getProducts();
      if (cachedProducts.isNotEmpty) {
        return Right(cachedProducts);
      }
      // If no cached data, return the original error
      return Left(ServerFailure(errMessage: e.message));
    }
  }
}
