import 'package:cache_and_theme_task_mentorship/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/products/data/repos/products_repo.dart';
import '../../features/products/presentation/screens/products_screen.dart';
import '../../features/products/presentation/cubits/products_cubit.dart';
import '../services/setup_service_locator.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.products:
      return MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) =>
              ProductCubit(getIt.get<ProductsRepo>())..getProducts(),
          child: const ProductsScreen(),
        ),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text("No route defined for ${settings.name}")),
        ),
      );
  }
}
