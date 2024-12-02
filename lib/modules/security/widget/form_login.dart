import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/text_button_widget.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';

class FormLogin extends StatefulWidget {


  const FormLogin({super.key, required this.emailController, required this.passwordController, this.passwordConfirmController,  this.isRegister = false, required this.buttonPrimaryText, required this.buttonSecondaryText, required this.onPressPrimaryButton, required this.onPressSecondaryButton});
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? passwordConfirmController;
  final bool isRegister;
  final String buttonPrimaryText;
  final String buttonSecondaryText;
  final void Function() onPressPrimaryButton;
  final void Function() onPressSecondaryButton;

  @override
  State<FormLogin> createState() => _FormLoginState();


}

class _FormLoginState extends State<FormLogin> {
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Bienvenido', style: TextStyle(
            fontSize: 30,
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.bold
        ),),
        SizedBox(height: size.height *0.02,),
        TextFormFieldWidget(
          
          hintText: 'correo@electronico.com',
        ),
        SizedBox(height: size.height *0.02,),
        TextFormFieldWidget(
          hintText: 'Contraseña',
          obscureText: obscure,
          suffixIcon: IconButton(onPressed: (){
            obscure = !obscure;
            setState(() {
              
            });
          }, icon: obscure ? Icon(Icons.remove_red_eye_outlined): Icon(Icons.visibility_off_outlined)),
        ),
        SizedBox(height: size.height *0.02,),
        FilledButtonWidget(text: widget.buttonPrimaryText),
        TextButtonWidget(text: widget.buttonSecondaryText),
        SizedBox(height: size.height *0.02,),
        TextButtonWidget(text: 'Ingresar como usario Invitado'),
      ],
    );
  }
}