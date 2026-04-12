import 'package:cache_and_theme_task_mentorship/core/errors/exception.dart';
import 'package:cache_and_theme_task_mentorship/features/products/data/data_source/product_local_data_source.dart';
import 'package:cache_and_theme_task_mentorship/features/products/domain/repos/products_repo.dart';
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
      
      // Save all fetched products to cache
      await localDataSource.saveProductsToCache(
        products: response,
        clear: skip == 0, // Clear cache only on the first page to refresh data
      );
      
      return Right(response);
    } on CustomException catch (e) {
      // Fallback to local data if remote fails
      final localProducts = await localDataSource.getProducts(skip: skip, limit: limit);
      if (localProducts.isNotEmpty) {
        return Right(localProducts);
      }
      return Left(ServerFailure(errMessage: e.message));
    } catch (e) {
      // General error fallback
      final localProducts = await localDataSource.getProducts(skip: skip, limit: limit);
      if (localProducts.isNotEmpty) {
        return Right(localProducts);
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<List<ProductModel>> getLocalProducts() async {
    // Return the first page of local products for initial display
    final cachedProducts = await localDataSource.getProducts(skip: 0, limit: 10);
    return cachedProducts;
  }
}
