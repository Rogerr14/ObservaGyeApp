import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/security/widget/form_login.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/layout_auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return LayoutAuth(
      requiredStack: false,
     child: Container(
      alignment: Alignment.center,
      width: size.width * 0.9,
      height: size.height* 0.5,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FormLogin(
          emailController: emailController, 
          passwordController: passwordController, 
          buttonPrimaryText: 'Iniciar Sesion',
          onPressPrimaryButton: (){
            final registerPageKey = GlobalHelper.genKey();
            fp.showAlert(key: registerPageKey, content: Column());
          },
          onPressSecondaryButton: (){

          },
          buttonSecondaryText: '¿No tienes cuenta?, Registrate',
          ),
      ),
    ));
  }
}