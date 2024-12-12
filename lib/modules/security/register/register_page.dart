import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/security/widget/form_login.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/layout_auth.dart';
import 'package:observa_gye_app/shared/widget/text_button_widget.dart';
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
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController= TextEditingController();
  final TextEditingController lastNameController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutAuth(
      requiredStack: false,
      keyDismiss:  widget.keyPage,
      isRegister: true,
      nameInterceptor: 'registerPage',
      child:  Column(
        children: [
          FormLogin(
              titlePage: 'Regístrate',
              isRegister: true,
              emailController: emailController, 
              passwordController: passwordController, 
              phoneController: phoneController,
              nameController: nameController,
              lastNameController: lastNameController,
              buttonPrimaryText: 'Registrate',
              onPressPrimaryButton: (){
                // fp.showAlert(key: registerPageKey, content: Column());
              },
              onPressSecondaryButton: (){
                final fp = Provider.of<FunctionalProvider>(context,listen: false);
                fp.dismissPage(key: widget.keyPage!);
              },
              buttonSecondaryText: 'Inicia Sesion',
              ),
        ],
      ));
  }
}