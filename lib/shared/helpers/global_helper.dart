import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:observa_gye_app/modules/404/pages/page_404.dart';
import 'package:observa_gye_app/shared/routes/app_routes.dart';

class GlobalHelper {
  // static slideTransitionNavigationPage(BuildContext context, String routeName, {String? type}) {
  //   final route = AppRoutes.routes[routeName];
  //   final page = (route != null) ? route.call(context) : const PageNotFound();

  //   Navigator.push(context, slideTransition(context, page));
  // }

  // static Route slideTransition(BuildContext context, Widget page) {
  //   return PageRouteBuilder(
  //     //fullscreenDialog: true,
  //     pageBuilder: (context, animation, secondaryAnimation) => page,
  //     transitionDuration: const Duration(milliseconds: 2000),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(0.0, 1.0);
  //       const end = Offset.zero;
  //       const curve = Curves.fastOutSlowIn;

  //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  // static navigateToPage(BuildContext context, String routeName, {String? type}) {
  //   final route = AppRoutes.routes[routeName];
  //   switch (type) {
  //     case 'android':
  //       final page = (route != null) ? route.call(context) : const PageNotFound();
  //       Navigator.push(context, navigationFadeIn(context, page));
  //       // Navigator.push(context,
  //       // MaterialPageRoute(builder: route ?? (context) => const PageNotFound()));
  //       break;
  //     case 'ios':
  //       Navigator.push(
  //           context,
  //           CupertinoPageRoute(
  //               builder: route ?? (context) => const PageNotFound()));
  //       // Navigator.push(context,
  //       // CupertinoPageRoute(builder: route ?? (context) => const PageNotFound()));
  //       break;
  //     default:
  //       final page = (route != null) ? route.call(context) : const PageNotFound();
  //       Navigator.pushReplacement(context, navigationFadeIn(context, page));
  //     //  final page = (route!=null)?route.call(context):const PageNotFound();
  //     //   Navigator.pushReplacement(context,
  //     //                         navigationFadeIn(
  //     //                             context, page, 1600));
  //   }
  // }

  static navigateToPageRemove(BuildContext context, String routeName) {
    final route = AppRoutes.routes[routeName];
    final page = (route != null) ? route.call(context) : const PageNotFound();
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        fullscreenDialog: true,
         reverseTransitionDuration: const Duration(milliseconds: 100),
        transitionDuration: const Duration(milliseconds: 100),
        pageBuilder: (context, animation, _) => 
        FadeTransition(
          opacity: animation,
          child: page,
        ),
      ),
      (route) => false,
    );
  }

  static Route navigationFadeIn(BuildContext context, Widget page) {
    return PageRouteBuilder(
      fullscreenDialog: true,
      reverseTransitionDuration: const Duration(milliseconds: 100),
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: page,
        );
      },
    );
  }

  static GlobalKey genKey() {
    GlobalKey key = GlobalKey();
    return key;
  }

  static String device = (Platform.isAndroid) ? "android" : "ios";

  static dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  // static String formatDate({ required String dateStr}){
  //   DateTime date = DateFormat('dd/MM/yyyy HH:mm').parse(dateStr);
  //   String formatDate = DateFormat('EEEE, dd \'de\' MMMM \'de\' yyyy HH:mm', "es").format(date);
  //   return formatDate[0].toUpperCase() + formatDate.substring(1).toLowerCase();
  // }
}