import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_defaultTheme);

  static final _defaultTheme = ThemeData(
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(color: Colors.blue),
    brightness: Brightness.light,
  );

  void changeTheme(MaterialColor themeColor, Brightness themeBrightness) {
    final colorTheme = ThemeData(
      primarySwatch: themeColor,
      primaryColor: themeColor,
      appBarTheme: AppBarTheme(color: themeColor),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: themeColor),
      brightness: themeBrightness,
    );
    emit(colorTheme);
  }
}
