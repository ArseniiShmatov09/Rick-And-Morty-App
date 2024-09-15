import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/presentation/app_colors/app_colors.dart';

final darkTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.mainBlack,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.mainGrey,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.mainBlack,
    brightness: Brightness.dark,
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: MaterialStateProperty.all(
        AppColors.mainGrey,
      ),
    ),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.black,
    indicatorColor: AppColors.mainGrey,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.mainBlack,
    hintStyle: TextStyle(color: AppColors.mainWhite),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.mainWhite),
    ),
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.mainWhite,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.mainGrey,
   // color: AppColors.mainWhite,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.mainWhite,
    brightness: Brightness.light,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: AppColors.mainWhite,
    indicatorColor: AppColors.mainGrey,
  ),
);
