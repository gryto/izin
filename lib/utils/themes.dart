

import 'package:flutter/material.dart';

import 'constants/colors.dart';

final ThemeData darkTheme = ThemeData(
  primarySwatch: ColorApp.materialDark,
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: ColorApp.materialLight,
  
  textTheme:const TextTheme(
    bodySmall: TextStyle(color: ColorApp.dark), // text biasa
    bodyMedium: TextStyle(color: ColorApp.dark), // text biasa
    bodyLarge: TextStyle(color: ColorApp.dark), // text biasa
  ),
  iconTheme: const IconThemeData(color: ColorApp.light),
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorApp.dark,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: ColorApp.light),
    iconTheme: IconThemeData(color: ColorApp.light)
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
        WidgetStateProperty.all<Color>(const Color(ColorApp.darkColor)),
    )
  ),
  textButtonTheme:
      TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            const Color(ColorApp.darkColor)
          ),
          textStyle: WidgetStateProperty.all<TextStyle>(
            const TextStyle(
              fontSize: 16,
              color: ColorApp.light
            )
          ))),
);

final ThemeData lightTheme = ThemeData(
  primarySwatch: ColorApp.materialLight,
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: ColorApp.materialDark,
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: ColorApp.light), // text biasa
    bodyMedium: TextStyle(color: ColorApp.light), // text biasa
    bodyLarge: TextStyle(color: ColorApp.light), // text biasa
  ),
  iconTheme: const IconThemeData(color: ColorApp.dark),
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorApp.light,
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: ColorApp.dark),
      iconTheme: IconThemeData(color: ColorApp.dark)),
  iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
    backgroundColor:
        WidgetStateProperty.all<Color>(const Color(ColorApp.lightColor)),
  )),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.all<Color>(const Color(ColorApp.lightColor)),
          textStyle: WidgetStateProperty.all<TextStyle>(
              const TextStyle(fontSize: 16, color: ColorApp.dark)))),
);

// final ThemeData appDarkThemeData = ThemeData.dark();
