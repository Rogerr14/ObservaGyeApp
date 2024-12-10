import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/text_button_widget.dart';

class PreAuthPage extends StatefulWidget {
  const PreAuthPage({super.key});

  @override
  State<PreAuthPage> createState() => _PreAuthPageState();
}

class _PreAuthPageState extends State<PreAuthPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: AppTheme.primaryColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppTheme.logoApp),
                FilledButtonWidget(
                  text: 'Iniciar Sesion',
                  color: AppTheme.secondaryColor,
                  colorText: AppTheme.primaryColor,
                  width: size.width * 0.02,
                  borderRadius: 10,
                  onPressed: (){
                    GlobalHelper.navigateToPageRemove(context, '/login');
                  },
                ),
                TextButtonWidget(
                  text: 'Ingresar como Invitado',
                  color: AppTheme.secondaryColor,
                  
                ),
              ],
            ),
          ),
        ));
  }
}
