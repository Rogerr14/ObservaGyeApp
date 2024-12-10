import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/security/register/register_page.dart';
import 'package:observa_gye_app/modules/security/service/security_service.dart';
import 'package:observa_gye_app/modules/security/widget/form_login.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/layout_auth.dart';
import 'package:observa_gye_app/shared/widget/text_button_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>>? keyPage;
  const LoginPage({super.key, this.keyPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  _login() async{

    SecurityService securityService = SecurityService();
    final body = {
    "correo": emailController.text,
    "password": passwordController.text
    };

    final response = await securityService.login(context, body);
    if(!response.error){
      GlobalHelper.navigateToPageRemove(context, '/home');
    }
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return LayoutAuth(
      // requiredStack: false,
     child: Column(
       children: [
         Container(
          alignment: Alignment.center,
          // width: size.width * 0.9,
          height: size.height* 0.7,
          decoration: BoxDecoration(
            color: AppTheme.secondaryColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FormLogin(
              emailController: emailController, 
              passwordController: passwordController, 
              buttonPrimaryText: 'Iniciar Sesion',
              onPressPrimaryButton: (){
                _login();
              },
              onPressSecondaryButton: (){
                final registerPageKey = GlobalHelper.genKey();
                fp.addPage(key: registerPageKey, content: RegisterPage(key: registerPageKey, keyPage: registerPageKey,));
                
              },
              buttonSecondaryText: '¿No tienes cuenta?, Registrate',
              ),
          ),
             ),
       ],
     ));
  }
}