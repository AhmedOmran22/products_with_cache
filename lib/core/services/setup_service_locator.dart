import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/products/data/data_source/product_local_data_source.dart';
import '../../features/products/data/data_source/products_remote_data_source.dart';
import '../../features/products/domain/repos/products_repo.dart';
import '../../features/products/domain/use_case/get_products_use_case.dart';
import '../../features/products/domain/use_case/sort_products_use_case.dart';
import '../../features/products/data/repos/products_repo_impl.dart';
import 'api_service.dart';
import 'dio_consumer.dart';
import 'local_data_base_service.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<ApiService>(DioConsumer(dio: getIt<Dio>()));
  getIt.registerSingleton<LocalDataBaseService>(LocalDataBaseService());
  getIt.registerSingleton<ProductsLocalDataSource>(
    ProductsLocalDataSource(localDataBaseService: getIt.get<LocalDataBaseService>()),
  );
  getIt.registerSingleton<ProductsRemoteDataSource>(
    ProductsRemoteDataSource(apiService: getIt<ApiService>()),
  );
  getIt.registerSingleton<ProductsRepo>(
    ProductsRepoImpl(
      remoteDataSource: getIt<ProductsRemoteDataSource>(),
      localDataSource: getIt<ProductsLocalDataSource>(),
    ),
  );
  getIt.registerSingleton<GetProductsUseCase>(
    GetProductsUseCase(getIt<ProductsRepo>()),
  );
  getIt.registerSingleton<SortProductsUseCase>(SortProductsUseCase());
}
