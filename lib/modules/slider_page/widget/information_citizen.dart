import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class InformationCitizen extends StatelessWidget {
  const InformationCitizen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        Image.asset(AppTheme.citizenScienceImage, height: size.height * 0.4,),
         const Padding(
           padding: EdgeInsets.symmetric(horizontal: 20),
           child: TextTitleWidget(
            title: 'Una app de ciencia ciudadana que conecta a las personas con la naturaleza. Recopila y comparte datos para proteger los bosques de Guayaquil.',
            showShadow: false,
            color: AppTheme.white,
                   ),
         ),
      ],
    );
  }
}
