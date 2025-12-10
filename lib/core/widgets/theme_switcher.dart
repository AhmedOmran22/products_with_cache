import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme_cubit/theme_cubit.dart';
import '../constants/constants.dart';
import '../services/prefs.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      inactiveThumbColor: Colors.grey,
      activeColor: Theme.of(context).primaryColor,
      activeTrackColor: Colors.grey.shade700,
      value: Prefs.getBool(kIsDarkMode),
      onChanged: (value) {
        setState(() {
          Prefs.setBool(kIsDarkMode, value);
          BlocProvider.of<ThemeCubit>(context).getCurrentTheme();
        });
      },
    );
  }
}
