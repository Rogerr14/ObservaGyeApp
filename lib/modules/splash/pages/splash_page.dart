import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/404/pages/page_404.dart';
import 'package:observa_gye_app/modules/principal_modules/main_page/page/main_page.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/secure_storage.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/routes/app_routes.dart';
import 'package:provider/provider.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeSnap){
     Future.delayed(const Duration(seconds: 3), (){
      _verifySession();
     });
    });
    super.initState();
  }

    void _verifySession()async{
      final userData = await SecureStorage().getUserData();
      final fp =  Provider.of<FunctionalProvider>(context, listen: false);
      final sliderInformation = await SecureStorage().getInformation();
      if(userData != null){
        String userName = '${userData.name.split(' ').first} ${userData.lastName.split(' ').first}';
        fp.saveUserName(userName);
        Navigator.pushAndRemoveUntil(context, GlobalHelper.navigationFadeIn(context, const MainPage()), (route) => false);
      }else{

      if(sliderInformation){
        _goTo('/login');
      }else{
         _goTo('/sliders');
      }
      }
    }



   void _goTo(String routeName) {
    
    final route = AppRoutes.routes[routeName];
    final page = (route != null) ? route.call(context) : const PageNotFound();
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        // fullscreenDialog: true,
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeOutExpo;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          var fadeTween = Tween(begin: 0.0, end: 1.0);
          var fadeAnimation = animation.drive(fadeTween);
          return FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          );
        },

      ),
      (route) => false
    );
  }
  

  @override
  void dispose() {
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop){
        if(didPop){
          return;
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.primaryColor,
        resizeToAvoidBottomInset: true,
        body: Center(
          child: Container(
            width: size.width,
            height: size.height,
            alignment: FractionalOffset.center,
            
             
            child: Hero(
              tag: 'Logo  ',
              child: SvgPicture.asset(AppTheme.logoApp)),
            
            ),
        ),
      ),
    );
  }
}