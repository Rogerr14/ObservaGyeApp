import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/security/widget/form_login.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/layout_auth.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.keyPage});
  final GlobalKey<State<StatefulWidget>>? keyPage;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutAuth(
      requiredStack: false,
      keyDismiss:  widget.keyPage,
      nameInterceptor: 'registerPage',
      child:  Container(
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
          isRegister: true,
          emailController: emailController, 
          passwordController: passwordController, 
          passwordConfirmController: passwordConfirmController,
          buttonPrimaryText: 'Registrarse',
          onPressPrimaryButton: (){
            final registerPageKey = GlobalHelper.genKey();
            // fp.showAlert(key: registerPageKey, content: Column());
          },
          onPressSecondaryButton: (){
            final fp = Provider.of<FunctionalProvider>(context,listen: false);
            fp.dismissPage(key: widget.keyPage!);
          },
          buttonSecondaryText: '¿Ya tienes cuenta?, Inicia Sesion',
          ),
      ),
    ));
  }
}