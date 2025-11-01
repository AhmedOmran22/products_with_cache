import 'package:cache_and_theme_task_mentorship/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routes/on_generate_routes.dart';
import 'core/theme_cubit/theme_cubit.dart';

class CacheAndThemeTaskMentorship extends StatelessWidget {
  const CacheAndThemeTaskMentorship({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: state,
          onGenerateRoute: onGenerateRoute,
          initialRoute: AppRoutes.products,
        );
      },
    );
  }
}
