import 'package:cache_and_theme_task_mentorship/core/services/prefs.dart';
import 'package:cache_and_theme_task_mentorship/core/theme_cubit/theme_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cache_and_theme_task_mentorship.dart';
import 'core/services/setup_service_locator.dart';
import 'features/products/data/models/product_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Prefs.init();
  Hive.registerAdapter(ProductModelAdapter());
  setupServiceLocator();
  runApp(
    BlocProvider(
      create: (context) => ThemeCubit()..getCurrentTheme(),
      child: const CacheAndThemeTaskMentorship(),
    ),
  );
}
// 3omran testing mac for the comments
