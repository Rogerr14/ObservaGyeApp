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
                Image.asset(AppTheme.ilustrationSplash, height: size.height *0.35,),
                SvgPicture.asset(AppTheme.logoApp,height: size.height *0.06,),
                const SizedBox(height: 20,),
                FilledButtonWidget(
                  text: 'Iniciar Sesión',
                  colorText: AppTheme.primaryColor,
                  fontSize: 17,
                  color: AppTheme.secondaryColor,
                  width: size.width * 0.6,
                  height: size.height * 0.055,
                  
                  borderRadius: 10,
                  onPressed: (){
                    GlobalHelper.navigateToPageRemove(context, '/login');
                  },
                ),
                const SizedBox(height: 10,),
                const TextButtonWidget(
                  text: 'Ingresar como Invitado',
                  color: AppTheme.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ));
  }
}
