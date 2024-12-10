import 'package:flutter/material.dart';

class AppTheme {
  //colors
  // static const Color primaryColor = Color(0xFF1A3636);
  static const Color primaryColor = Color(0xFF344E41);
  static const Color secondaryColor = Color(0xFFFFFFFF);

  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;
  static const Color error = Color(0xffF94838);
  static const Color hinText = Color(0xff5B5B5B);
  static const Color grayShadow = Color(0xFFD9D9D9);

  //image routes
  static const String logoApp = 'assets/Observa_logo.svg';
  static const String ilustrationSplash = 'assets/ilustration_splash.png';
  static const String icon404Path = 'assets/404.svg';
  static const String iconErrorPath = "assets/error.svg";
  static const String iconCheckPath = "assets/check.svg";
  static const String plantSvg = "assets/hoja.png";

  static const String loading = "assets/loading.gif";

  ThemeData theme() {
    return ThemeData(
      textSelectionTheme: const TextSelectionThemeData(
        selectionHandleColor: AppTheme.primaryColor,
        //selectionColor: AppTheme.primaryColor,
        cursorColor: AppTheme.primaryColor,
      ),
      //  colorScheme: ColorScheme.fromSeed(
      //       seedColor: AppTheme.primaryColor,
      //     ),
      //textTheme: GoogleFonts.openSansTextTheme(),
      //textTheme: GoogleFonts.robotoTextTheme(),
      // textTheme: TextTheme(

      // ),
      fontFamily: 'Dubai',
      
      useMaterial3: true,
    );
  }
}
