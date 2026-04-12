import 'package:cache_and_theme_task_mentorship/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/products/domain/usecases/get_products_use_case.dart';
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
          )..getProducts(),
          child: const ProductsScreen(),
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
