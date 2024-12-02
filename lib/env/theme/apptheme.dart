

import 'package:flutter/material.dart';

class AppTheme {
  //colors
  // static const Color primaryColor = Color(0xFF1A3636);
  static const Color primaryColor = Color(0xFFA8CD89);



  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;
  static const Color error = Color(0xffF94838);
  static const Color hinText = Color(0xff5B5B5B);




  //image routes
  static const String logoApp = 'assets/Observa_logo.svg';
  static const String icon404Path = 'assets/404.svg';
  static const String iconErrorPath = "assets/error.svg";
  static const String iconCheckPath = "assets/check.svg";
  
  
  
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
      fontFamily: 'Roboto',
      useMaterial3: true,
    );
  }
}