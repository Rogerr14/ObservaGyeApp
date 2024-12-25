


import 'package:flutter/material.dart';
import 'package:observa_gye_app/modules/404/pages/page_404.dart';
import 'package:observa_gye_app/modules/home/page/home_page.dart';
import 'package:observa_gye_app/modules/pre_auth/page/pre_auth_page.dart';
import 'package:observa_gye_app/modules/security/login/page/login_page.dart';
import 'package:observa_gye_app/modules/splash/pages/splash_page.dart';

class AppRoutes {
  static const initialRoute = '/splash';

  static Map<String, Widget Function(BuildContext context)> routes = {
      '/splash' : (_)=> const SplashPage(),
      '/preAuth': (_)=>const PreAuthPage(),
      '/login': (_) =>const LoginPage(),
      '/home': (_)=> const HomePage()
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    return MaterialPageRoute(builder: (context) => const PageNotFound(),);
  }
}