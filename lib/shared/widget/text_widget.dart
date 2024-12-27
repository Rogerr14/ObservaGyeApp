import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';


class TextTitleWidget extends StatelessWidget {
  final String title;
  final double size;
  final Color color;
  final bool showShadow;
  const TextTitleWidget({super.key, required this.title,  this.size = 17, this.color = AppTheme.primaryColor, this.showShadow = true});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(
      
      fontSize: size,
       fontWeight: FontWeight.bold,
      color: color,
      shadows: (showShadow) ? const [
        Shadow(
            color: AppTheme.grayShadow,
            blurRadius: 0.2,
            offset: Offset(0.3, 4))
      ] : null
    ),);
  }
}



class TextSubtitleWidget extends StatelessWidget {
  final String subtitle;
  final double size;
  final Color color;
  final FontWeight fontWeight;

  const TextSubtitleWidget({super.key, required this.subtitle, this.size =  17, this.color = AppTheme.primaryColor,  this.fontWeight =  FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(subtitle, 
    style: TextStyle(
      color: color,
      fontSize: size,
        fontWeight: fontWeight,
      
    ),);
  }
}