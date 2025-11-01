import 'package:cache_and_theme_task_mentorship/core/services/prefs.dart';
import 'package:cache_and_theme_task_mentorship/core/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cache_and_theme_task_mentorship.dart';
import 'core/services/setup_service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  setupServiceLocator();
  runApp(
    BlocProvider(
      create: (context) => ThemeCubit()..getCurrentTheme(),
      child: const CacheAndThemeTaskMentorship(),
    ),
  );
}
