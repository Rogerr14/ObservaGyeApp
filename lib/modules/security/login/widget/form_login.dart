import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/security/login/model/user_model.dart';
import 'package:observa_gye_app/modules/security/recovery/page/recovery_pswrd.dart';
import 'package:observa_gye_app/modules/security/register/page/register_page.dart';
import 'package:observa_gye_app/modules/security/service/security_service.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/secure_storage.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/text_button_widget.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({
    super.key,
  });

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  bool visibityPassword = false;
  late FunctionalProvider fp;
  final _formLoginKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void initState() {
    fp = Provider.of<FunctionalProvider>(context, listen: false);
    super.initState();
  }

  _login() async {
    SecurityService securityService = SecurityService();
    final body = {
    "correo": _emailController.text,
    "password": _passwordController.text
    };

    final response = await securityService.login(context, body);
    if(!response.error){
     SecureStorage().setUserData(userModelFromJson(json.encode(response.data)));
     
     if(fp.alerts.isEmpty){

    GlobalHelper.navigateToPageRemove(context, '/main');
     }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key: _formLoginKey,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            TextFormFieldWidget(
              hintText: 'Correo electrónico',
              controller: _emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(
                Icons.alternate_email,
                color: AppTheme.primaryColor,
                size: 24,
              ),
              validator: (value) {
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                if (value!.trim().isEmpty) {
                  return 'El campo no debe estar vacío';
                } else if (!emailRegex.hasMatch(value)) {
                  return 'Por favor, ingrese un correo electrónico válido';
                }
                return null;
              },
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
              obscureText: visibityPassword,
              controller: _passwordController,
              suffixIcon: IconButton(
                onPressed: () {
                  visibityPassword = !visibityPassword;
                  setState(() {});
                },
                icon: Icon(
                  visibityPassword
                      ? Icons.remove_red_eye_outlined
                      : Icons.visibility_off_outlined,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'El campo contraseña no debe estar vacío.';
                }
                return null;
              },
            ),
            SizedBox(height: size.height * 0.05),
            FilledButtonWidget(
              text: 'Iniciar Sesión',
              width: 240,
              height: 45,
              borderRadius: 20,
              onPressed: () {
                if (_formLoginKey.currentState!.validate()) {
                  _login();
                }
              },
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            TextButtonWidget(
              text: 'Olvidé mi contraseña',
              fontSize: 15,
              onPressed: () {
                final recoveryPswrdKey = GlobalHelper.genKey();
                fp.addPage(
                  key: recoveryPswrdKey,
                  content: RecoveryPswrdPage(
                    key: recoveryPswrdKey,
                    keyDismiss: recoveryPswrdKey,
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextSubtitleWidget(
                  subtitle: '¿No tienes cuenta?',
                  size: 15,
                ),
                TextButtonWidget(
                  text: 'Registrate',
                  fontSize: 15,
                  onPressed: () {
                    final registerPageKey = GlobalHelper.genKey();
                    fp.addPage(
                        key: registerPageKey,
                        content: RegisterPage(
                          key: registerPageKey,
                          keyPage: registerPageKey,
                        ));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
