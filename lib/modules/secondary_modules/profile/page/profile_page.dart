import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/secondary_modules/profile/services/user_service.dart';
import 'package:observa_gye_app/modules/security/login/model/user_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/helpers/secure_storage.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/layout_generic.dart';
import 'package:observa_gye_app/shared/widget/text_button_widget.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> keyDismiss;
  const ProfilePage({super.key, required this.keyDismiss});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool editable = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  UserModel? userModel;
  bool _editable = false;
  late FunctionalProvider fp;

  @override
  void initState() {
    fp = Provider.of<FunctionalProvider>(context, listen: false);
    super.initState();
    _getData();
  }

  _getData() async {
    userModel = await SecureStorage().getUserData();
    _nameController.text = userModel!.name;
    _lastNameController.text = userModel!.lastName;
    _phoneController.text = userModel!.phone;
    setState(() {});
  }

  _editUser() async {
    final body = {
      "nombres": _nameController.text.toUpperCase(),
      "apellidos": _lastNameController.text.toUpperCase(),
      "telefono": _phoneController.text
    };

    final response = await UserService().modifyUser(context, body);
    if (!response.error) {
      userModel = response.data!;
      final keyUserModify = GlobalHelper.genKey();
      fp.showAlert(
        key: keyUserModify,
        content: AlertGeneric(
          content: OkGeneric(
              message: 'Datos modificados correctamente',
              keyToClose: keyUserModify,
              onPress: (){
      SecureStorage().setUserData(userModel!);
                fp.dismissAlert(key: keyUserModify);
                _getData();
                 String userName = '${userModel!.name.split(' ').first} ${userModel!.lastName.split(' ').first}';
                 fp.saveUserName(userName);
              },
              ),
          keyToClose: keyUserModify,
          
        ),
        
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return LayoutPageGeneric(
      keyDismiss: widget.keyDismiss,
      requiredStack: false,
      nameInterceptor: 'ProfilePage',
      iconSuffix: IconButton(
          onPressed: () {
            if(_editable){
              _editUser();
            }
            _editable = !_editable;
            setState(() {});
          },
          icon: TextTitleWidget(title: !_editable ? 'Editar' : 'Guardar')),
      child: userModel == null
          ? SizedBox()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextSubtitleWidget(
                      subtitle: 'Perfil',
                      size: 20,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        AppTheme.iconUser,
                        height: responsive.hp(10),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextTitleWidget(
                        title: '${userModel!.name} ${userModel!.lastName}',
                        size: responsive.wp(5.5),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: TextTitleWidget(title: 'Correo'),
                    ),
                    TextSubtitleWidget(
                      subtitle: '${userModel!.email}',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: TextTitleWidget(title: 'Nombres'),
                    ),
                    _editable
                        ? TextFormFieldWidget(
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            prefixIcon: const Icon(
                              Icons.person_outline_outlined,
                              color: AppTheme.primaryColor,
                              size: 24,
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'El campo no debe estar vacío.';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z\s]'))
                            ],
                          )
                        : TextSubtitleWidget(subtitle: userModel!.name),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: TextTitleWidget(title: 'Apellidos'),
                    ),
                    _editable
                        ? TextFormFieldWidget(
                            controller: _lastNameController,
                            textInputAction: TextInputAction.next,
                            prefixIcon: const Icon(
                              Icons.person_outline_outlined,
                              color: AppTheme.primaryColor,
                              size: 24,
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'El campo no debe estar vacío.';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z\s]'))
                            ],
                          )
                        : TextSubtitleWidget(subtitle: userModel!.lastName),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: TextTitleWidget(title: 'Telefono'),
                    ),
                    _editable
                        ? TextFormFieldWidget(
                            controller: _phoneController,
                            textInputAction: TextInputAction.next,
                            prefixIcon: const Icon(
                              Icons.phone_outlined,
                              color: AppTheme.primaryColor,
                              size: 24,
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'El campo contraseña no debe estar vacío.';
                              }
                              return null;
                            },
                          )
                        : TextSubtitleWidget(subtitle: userModel!.phone),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    TextButtonWidget(
                      text: 'Cambiar contraseña',
                      onPressed: () {
                        final keyChangePassword = GlobalHelper.genKey();
                        fp.showAlert(
                          key: keyChangePassword,
                          content: AlertGeneric(
                              content:
                                  changePasswordForm(fp, keyChangePassword)),
                          closeAlert: true,
                        );
                      },
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: TextSubtitleWidget(subtitle: 'Version 1.0.0'),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget changePasswordForm(
      FunctionalProvider fp, GlobalKey<State<StatefulWidget>> keyDismiss) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final formKey = GlobalKey<FormState>();

    _changuePassword() async {
      final body = {
        "oldPassword": passwordController.text.trim(),
        "newPassword": newPasswordController.text.trim()
      };
      final response = await UserService().changePassword(context, body);
      if (!response.error) {
        final keyOkPassword = GlobalHelper.genKey();
        String message = '${response.message}\nInicie sesión nuevamente';
        fp.showAlert(
          key: keyOkPassword,
          content: AlertGeneric(
            content: OkGeneric(
              message: message,
              keyToClose: keyOkPassword,
              onPress: () {
                fp.clearAllAlert();
                GlobalHelper.navigateToPageRemove(context, '/login');
              },
            ),
          ),
        );
      }
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          const TextTitleWidget(title: 'Cambiar Contraseña'),
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: TextTitleWidget(title: 'Contraseña Anterior'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormFieldWidget(
            prefixIcon: const Icon(
              Icons.password_sharp,
              color: AppTheme.primaryColor,
              size: 24,
            ),
            hintText: 'Contraseña Anterior',
            controller: passwordController,
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
          const Align(
            alignment: Alignment.centerLeft,
            child: TextTitleWidget(title: 'Contraseña Nueva'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormFieldWidget(
            prefixIcon: const Icon(
              Icons.password_sharp,
              color: AppTheme.primaryColor,
              size: 24,
            ),
            hintText: 'Contraseña Nueva',
            controller: newPasswordController,
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
          const Align(
            alignment: Alignment.centerLeft,
            child: TextTitleWidget(title: 'Confirmar Contraseña'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormFieldWidget(
            prefixIcon: const Icon(
              Icons.password_sharp,
              color: AppTheme.primaryColor,
              size: 24,
            ),
            hintText: 'Confirmar Contraseña',
            controller: confirmPasswordController,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'El campo contraseña no debe estar vacío.';
              } else {
                if (value.trim() != newPasswordController.text.trim()) {
                  return 'No coiniciden las contraseñas';
                }
              }

              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          FilledButtonWidget(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  _changuePassword();
                }
              },
              text: 'Aceptar'),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
