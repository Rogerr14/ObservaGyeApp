import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/security/login/widget/form_login.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/widget/layout_auth.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class LoginPage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>>? keyPage;
  const LoginPage({super.key, this.keyPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return LayoutAuth(
        // requiredStack: false,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: size.height * 0.35,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              AppTheme.logoApp,
              height: size.height * 0.06,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Una app de ciencia ciudadana',
              style: TextStyle(
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 17),
            ),
          ]),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              '¡Bienvenido!',
              style: TextStyle(
                  color: AppTheme.secondaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width,
            decoration: const BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40),
              ),
            ),
            child:  const Padding(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextTitleWidget(
                      title: 'Iniciar Sesión',
                      size: 30,
                    ),
                  ),
                  FormLogin()
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
