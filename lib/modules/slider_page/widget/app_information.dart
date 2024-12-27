import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class AppInformation extends StatelessWidget {
  const AppInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        Image.asset(AppTheme.observationImage, height: size.height * 0.4,),
         const Padding(
           padding: EdgeInsets.symmetric(horizontal: 20),
           child: TextTitleWidget(
            title: 'Con nuestra app, puedes reportar avistamientos de flora, alertar sobre incendios o contaminación.',
            showShadow: false,
            color: AppTheme.white,
                   ),
         ),
      ],
    );
  }
}