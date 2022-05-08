import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';

ThemeData appTheme({
  Color mainColor = Colors.white,
  Color secMainColor = Colors.black,
}) =>
    ThemeData.light().copyWith(
      appBarTheme: myAppBarTheme(),
      textTheme: const TextTheme().copyWith(
        headline1: const TextStyle(color: AppColors.mainColor),
        headline6: const TextStyle(color: AppColors.mainColor),
        bodyText2: const TextStyle(color: AppColors.mainColor),
      ),
    );

ThemeData appDarkTheme() => ThemeData.dark().copyWith(
      textTheme: const TextTheme().copyWith(
        headline1: const TextStyle().copyWith(color: Colors.white),
        headline6: const TextStyle().copyWith(color: Colors.white),
        bodyText1: const TextStyle().copyWith(color: Colors.white),
        bodyText2: const TextStyle().copyWith(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(),
      appBarTheme: myAppBarTheme(
          mainColor: AppColors.mainBlackColor,
          secMainColor: Colors.white,
          brightness: Brightness.light),
      scaffoldBackgroundColor: AppColors.mainBlackColor,
      canvasColor: AppColors.mainBlackColor,
      primaryColor: AppColors.mainColor,
    );

AppBarTheme myAppBarTheme(
        {Color mainColor = Colors.white,
        Color secMainColor = AppColors.mainColor,
        brightness = Brightness.dark}) =>
    AppBarTheme(
      actionsIconTheme: IconThemeData(color: secMainColor, size: 30),
      iconTheme: IconThemeData(color: secMainColor),
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: mainColor, statusBarIconBrightness: brightness),
      elevation: 0,
      backgroundColor: mainColor,
      titleTextStyle: TextStyle(color: secMainColor, fontSize: 20, fontWeight: FontWeight.bold),
    );
