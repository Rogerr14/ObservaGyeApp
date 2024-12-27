import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/security/register/widget/form_register.dart';
import 'package:observa_gye_app/shared/widget/layout_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.keyPage});
  final GlobalKey<State<StatefulWidget>>? keyPage;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutAuth(
        requiredStack: false,
        keyDismiss: widget.keyPage,
        isRegister: true,
        nameInterceptor: 'registerPage',
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                    width: size.width,
                    height: size.height * 0.8,
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(40))),
                    child: FormRegister(keyPage: widget.keyPage!,)),
                Positioned(
                    top: size.height * -0.1,
                    right: 0,
                    child: Image.asset(
                      AppTheme.plantSvg,
                      height: size.height * 0.15,
                    )),
              ],
            ),
          ],
        ));
  }
}
