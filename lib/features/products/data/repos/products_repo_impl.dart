import 'package:cache_and_theme_task_mentorship/core/errors/exception.dart';
import 'package:cache_and_theme_task_mentorship/features/products/data/repos/products_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../data_source/products_remote_data_source.dart';
import '../models/product_model.dart';

class ProductsRepoImpl implements ProductsRepo {
  final ProductsRemoteDataSource remoteDataSource;

  ProductsRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts({
    int skip = 0,
    int limit = 10,
  }) async {
    try {
      final response = await remoteDataSource.getProducts(skip: skip, limit: limit);
      return Right(response);
    } on CustomException catch (e) {
      return Left(ServerFailure(errMessage: e.message));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
