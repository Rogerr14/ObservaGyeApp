import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/layout_auth.dart';
import 'package:observa_gye_app/shared/widget/text_button_widget.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class RecoveryPswrdPage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> keyDismiss;
  const RecoveryPswrdPage({super.key, required this.keyDismiss});

  @override
  State<RecoveryPswrdPage> createState() => _RecoveryPswrdPageState();
}

class _RecoveryPswrdPageState extends State<RecoveryPswrdPage> {
  final _formRecoveryKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final responsive = Responsive(context);
    return LayoutAuth(
        keyDismiss: widget.keyDismiss,
        requiredStack: false,
        nameInterceptor: 'RecoveryPswrdPage',
        child: Column(
          children: [
            SizedBox(height: responsive.height * 0.2),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                    width: responsive.width,
                    height: responsive.height * 0.8,
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Form(
                        child: Column(
                          children: [
                            SizedBox(
                              height: responsive.height * 0.03,
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
                                    fp.dismissPage(key: widget.keyDismiss);
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: responsive.height * 0.03,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: TextTitleWidget(
                                title: 'Recuperar Contraseña',
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              height: responsive.height * 0.03,
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
                                final emailRegex =
                                    RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                if (value!.trim().isEmpty) {
                                  return 'El campo no debe estar vacío';
                                } else if (!emailRegex.hasMatch(value)) {
                                  return 'Por favor, ingrese un correo electrónico válido';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: responsive.hp(2),),
                            FilledButtonWidget(
                              text: 'Aceptar',
                              width: responsive.wp(50),
                              height: responsive.hp(5),
                              borderRadius: 20,
                              onPressed: () {
                                if (_formRecoveryKey.currentState!
                                    .validate()) {}
                              },
                            ),
                          ],
                        ),
                      ),
                    )),
                Positioned(
                    top: responsive.height * -0.1,
                    right: 0,
                    child: Image.asset(
                      AppTheme.plantSvg,
                      height: responsive.height * 0.15,
                    )),
              ],
            ),
          ],
        ));
  }
}
