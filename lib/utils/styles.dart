import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData appTheme({
  Color mainColor = Colors.white,
  Color secMainColor = Colors.black,
}) =>
    ThemeData(
      textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: secMainColor)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          //selectedItemColor: AppColors.mainColor,
          unselectedItemColor: AppColors.mainBlackColor,
          selectedIconTheme: IconThemeData(size: 30, color: mainColor),
          backgroundColor: mainColor,
          elevation: 20),
      scaffoldBackgroundColor: mainColor,
      appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(color: secMainColor, size: 30),
        iconTheme: const IconThemeData(color: AppColors.mainColor),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: mainColor, statusBarIconBrightness: Brightness.dark),
        elevation: 0,
        backgroundColor: mainColor,
        titleTextStyle: TextStyle(color: secMainColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
