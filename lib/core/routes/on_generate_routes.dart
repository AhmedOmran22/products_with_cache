import 'package:cache_and_theme_task_mentorship/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/products/domain/repos/products_repo.dart';
import '../../features/products/domain/use_case/get_products_use_case.dart';
import '../../features/products/domain/use_case/sort_products_use_case.dart';
import '../../features/products/presentation/screens/filter_products_screen.dart';
import '../../features/products/presentation/cubits/filter_products_cubit.dart';
import '../../features/products/domain/entities/product_entity.dart';
import '../../features/products/presentation/screens/products_details_screen.dart';
import '../../features/products/presentation/screens/products_screen.dart';
import '../../features/products/presentation/cubits/products_cubit.dart';
import '../services/setup_service_locator.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.products:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => ProductCubit(
            getProductsUseCase: getIt.get<GetProductsUseCase>(),
            productsRepo: getIt.get<ProductsRepo>(),
          )..getProducts(),
          child: const ProductsScreen(),
        ),
      );
    case AppRoutes.filterProducts:
      final products = settings.arguments as List<ProductEntity>;
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => FilterProductsCubit(
            sortProductsUseCase: getIt.get<SortProductsUseCase>(),
            initialProducts: products,
          ),
          child: const FilterProductsScreen(),
        ),
      );
    case AppRoutes.productsDetails:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const ProductsDetailsScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text("No route defined for ${settings.name}")),
        ),
      );
  }
}
