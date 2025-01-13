import 'package:flutter/material.dart';

class AppTheme {
  //colors
  // static const Color primaryColor = Color(0xFF1A3636);
  static const Color primaryColor = Color(0xFF344E41);
  static const Color secondaryColor = Color(0xFFFFFFFF);

  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;
  static const Color error = Color(0xffF94838);
  static const Color hinText = Color.fromARGB(255, 163, 160, 160);
  static const Color grayShadow = Color(0xFFD9D9D9);
  static const Color yellow = Color(0xFFffd97d);
  static const Color green = Color(0xFF70e000);
  static const Color red = Color(0xFFee6055);

  //image routes
  static const String logoApp = 'assets/Observa_logo.svg';
  static const String ilustrationSplash = 'assets/ilustration_splash.png';
  static const String plantSvg = "assets/hoja.png";
  static const String citizenScienceImage = "assets/citizen_science.png";
  static const String connectionImage = "assets/connection.png";
  static const String observationImage = "assets/observation.png";
  static const String loading = "assets/loading.gif";

  //Icons App
  static const String icon404Path = 'assets/404.svg';
  static const String iconErrorPath = "assets/error.svg";
  static const String iconCheckPath = "assets/check.svg";
  static const String iconHome = "assets/Home.svg";
  static const String iconAlert = "assets/Alert.svg";
  static const String iconObservation = "assets/AddObservation.svg";
  static const String iconMyAport = "assets/MyObservation.svg";
  static const String iconSearch = "assets/Search.svg";
  static const String iconMap = "assets/IconMap.svg";
  static const String iconUser = "assets/user.png";
  static const String iconCautionPath = "assets/caution.svg";

  ThemeData theme() {
    return ThemeData(
      focusColor: AppTheme.primaryColor,
      textSelectionTheme: const TextSelectionThemeData(
        selectionHandleColor: AppTheme.primaryColor,
        //selectionColor: AppTheme.primaryColor,
        selectionColor: AppTheme.primaryColor,
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
