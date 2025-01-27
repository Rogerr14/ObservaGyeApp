import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/security/service/security_service.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/text_button_widget.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class FormRegister extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> keyPage;
  const FormRegister({super.key, required this.keyPage});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final _formRegisterKey = GlobalKey<FormState>();
  bool visibityPassword = false;



  _registerUser()async{
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
   SecurityService securityService = SecurityService();
   final body = {
  "id_rol": 2,
  "nombres": _nameController.text.toUpperCase(),
  "apellidos" : _lastNameController.text.toUpperCase(),
  "correo": _emailController.text.trim(),
  "password": _passwordController.text.trim(),
  "telefono":_phoneController.text.trim()
  };

  final response = await securityService.createAccount(context, body);
  if(!response.error){
    final alertCreateAccountKey = GlobalHelper.genKey();
    fp.showAlert(key: alertCreateAccountKey, content: AlertGeneric(content: OkGeneric(message: response.message,  keyToClose: alertCreateAccountKey, onPress: (){
      fp.dismissAlert(key: alertCreateAccountKey);
      fp.dismissPage(key: widget.keyPage);
    },)));
  }
}

  //Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key: _formRegisterKey,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: AppTheme.primaryColor,
                  size: 15,
                ),
                TextButtonWidget(
                  text: 'Iniciar Sesión',
                  onPressed: () {
                    fp.dismissPage(key: widget.keyPage);
                  },
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextTitleWidget(
                title: 'Regístrate',
                size: 30,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextFormFieldWidget(
                    hintText: 'Nombres',
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(
                      Icons.person_outline_outlined,
                      color: AppTheme.primaryColor,
                      size: 24,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                    ],
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'El campo no debe estar vacío.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormFieldWidget(
                    hintText: 'Apellidos',
                    controller: _lastNameController,
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(
                      Icons.person_outline_outlined,
                      color: AppTheme.primaryColor,
                      size: 24,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
                    ],
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'El campo contraseña no debe estar vacío.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormFieldWidget(
                    hintText: 'Telefono',
                    controller: _phoneController,
                    textInputAction: TextInputAction.next,
                    prefixIcon: const Icon(
                      Icons.phone_outlined,
                      color: AppTheme.primaryColor,
                      size: 24,
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'El campo contraseña no debe estar vacío.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormFieldWidget(
                    hintText: 'Correo electrónico',
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 40,
                  ),
                  FilledButtonWidget(
                    text: 'Regístrate',
                    width: 240,
                    height: 45,
                    borderRadius: 20,
                    onPressed: () {
                      if (_formRegisterKey.currentState!.validate()) {
                        _registerUser();
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
