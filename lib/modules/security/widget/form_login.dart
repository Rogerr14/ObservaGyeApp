import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/text_button_widget.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';
import 'package:provider/provider.dart';

class FormLogin extends StatefulWidget {
  const FormLogin(
      {super.key,
      required this.emailController,
      required this.passwordController,
      this.phoneController,
      this.nameController,
      this.lastNameController,
      this.isRegister = false,
      required this.buttonPrimaryText,
      required this.buttonSecondaryText,
      required this.onPressPrimaryButton,
      required this.onPressSecondaryButton, this.titlePage = ''});
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? phoneController;
  final TextEditingController? nameController;
  final TextEditingController? lastNameController;
  final bool isRegister;
  final String buttonPrimaryText;
  final String buttonSecondaryText;
  final void Function() onPressPrimaryButton;
  final void Function() onPressSecondaryButton;
  final String titlePage;

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: widget.isRegister ?   size.height* 0.8 : size.height * 0.6,
          width: double.infinity,
              decoration: const BoxDecoration(
                color: AppTheme.secondaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.03,),
              Visibility(
                visible: widget.isRegister,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: AppTheme.primaryColor, size: 15,),
                      TextButtonWidget(text: 'Iniciar Sesión', onPressed: widget.onPressSecondaryButton,)
                    ],
                  ) ,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    widget.titlePage,
                    style: TextStyle(
                        fontSize: 30,
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                              color: AppTheme.grayShadow,
                              blurRadius: 0.2,
                              offset: Offset(0.3, 4))
                        ]),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                  Visibility(
                    visible: widget.isRegister,
                    child: TextFormFieldWidget(
                      hintText: 'nombres',
                       fontSizeHint: 19,
                      controller: widget.nameController,
                      validator: (value){
                        if(value != null){
                          if(value.trim().isEmpty){
                            return 'Por favor ingrese su nombre';
                          }
                        }
                        return null;
                      },
                      maxWidth: size.width * 0.75,
                      maxHeigth: size.height * 0.06,
                      borderWith: 1.5,
                      showShading: true,
                      fillColor: AppTheme.grayShadow,
                      prefixIcon: const Icon(
                        Icons.person_2_outlined,
                        color: AppTheme.primaryColor,
                        size: 24,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.isRegister,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        TextFormFieldWidget(
                          hintText: 'apellidos',
                           fontSizeHint: 19,
                          controller: widget.lastNameController,
                          validator: (value){
                        if(value != null){
                          if(value.trim().isEmpty){
                            return 'Por favor ingrese su apellido';
                          }
                        }
                        return null;
                      },
                          maxWidth: size.width * 0.75,
                          maxHeigth: size.height * 0.06,
                          borderWith: 1.5,
                          showShading: true,
                          fillColor: AppTheme.grayShadow,
                          prefixIcon: const Icon(
                            Icons.person_2_outlined,
                            color: AppTheme.primaryColor,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  TextFormFieldWidget(
                    hintText: 'correo electrónico',
                    fontSizeHint: 19,
                    controller: widget.emailController,
                    maxWidth: size.width * 0.75,
                    maxHeigth: size.height * 0.06,
                    borderWith: 1.5,
                    showShading: true,
                    fillColor: AppTheme.grayShadow,
                    prefixIcon: const Icon(
                      Icons.alternate_email,
                      color: AppTheme.primaryColor,
                      size: 24,
                    ),
                  ),
                  Visibility(
                    visible: widget.isRegister,
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        TextFormFieldWidget(
                          hintText: 'telefono',
                           fontSizeHint: 19,
                          // controller: widget.emailController,
                          maxWidth: size.width * 0.75,
                          maxHeigth: size.height * 0.06,
                          borderWith: 1.5,
                          showShading: true,
                          fillColor: AppTheme.grayShadow,
                          prefixIcon: const Icon(
                            Icons.phone_outlined,
                            color: AppTheme.primaryColor,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  TextFormFieldWidget(
                    prefixIcon: const Icon(
                      Icons.password_sharp,
                      color: AppTheme.primaryColor,
                      size: 24,
                    ),
                    hintText: 'contraseña',
                    obscureText: obscure,
                    maxWidth: size.width * 0.75,
                    maxHeigth: size.height * 0.06,
                    borderWith: 1.5,
                    // showShading: true,
                    fillColor: AppTheme.grayShadow,
          
                    controller: widget.passwordController,
                    suffixIcon: IconButton(
                      onPressed: () {
                        obscure = !obscure;
                        setState(() {});
                      },
                      icon: obscure
                          ? const Icon(
                              Icons.remove_red_eye_outlined,
                              color: AppTheme.primaryColor,
                              size: 24,
                            )
                          : const Icon(
                              Icons.visibility_off_outlined,
                              color: AppTheme.primaryColor,
                              size: 24,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  FilledButtonWidget(
                    text: widget.buttonPrimaryText,
                    onPressed: widget.onPressPrimaryButton,
                    borderRadius: 10,
                    width: size.width * 0.5,
                  ),
                  Visibility(
                    visible: !widget.isRegister,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿No tienes cuenta?',
                          style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        TextButtonWidget(
                          text: widget.buttonSecondaryText,
                          onPressed: widget.onPressSecondaryButton,
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 10,),
                ],
              ),
            ],
          ),
        ),
         Visibility(
                          visible: widget.isRegister,
                           child: Positioned(
                                       top: size.height * -0.1,
                                       right: 0,
                                       child: Image.asset(AppTheme.plantSvg, height: size.height * 0.15,)),
                         ),
      ],
    );
  }
}
