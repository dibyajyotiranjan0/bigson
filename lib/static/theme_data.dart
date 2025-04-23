import 'package:bigsangrup/static/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  ThemeData themedata = ThemeData(
      // fontFamily: '',
      textTheme: const TextTheme(
        // Replace 'roboto' with the font you want
        // Theme.of(context).textTheme,

        displayLarge: const TextStyle(
          fontFamily: 'RedHatDisplay-Light',
          fontWeight: FontWeight.bold,
        ),
        displayMedium: const TextStyle(
          fontFamily: 'RedHatDisplay-Light',
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: const TextStyle(
          fontFamily: 'RedHatDisplay-Light',
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        bodyMedium: const TextStyle(
            fontFamily: 'RedHatDisplay-Light',
            fontWeight: FontWeight.normal,
            fontSize: 16),
        bodySmall: const TextStyle(
            fontFamily: 'RedHatDisplay-Light',
            // fontWeight: FontWeight.w300,
            fontSize: 14),
      ),
      scaffoldBackgroundColor: Colo.white,
      // colorScheme: ColorScheme.fromSeed(seedColor: Colo.primaryColor),
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colo.primaryColorSecond, //Color(0xfffac50e),
      ),
      appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colo.primaryColor, // Navigation bar
            statusBarColor: Colo.primaryColor, // Status bar
          ),
          foregroundColor: Colo.white,
          backgroundColor: Colo.white));
}
