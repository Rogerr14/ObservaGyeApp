import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';


class TextTitleWidget extends StatelessWidget {
  final String title;
  final double size;
  final Color color;
  const TextTitleWidget({super.key, required this.title,  this.size = 17, this.color = AppTheme.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(
      fontSize: size,
       fontWeight: FontWeight.bold,
      color: color,
      shadows: [
        Shadow(
            color: AppTheme.grayShadow,
            blurRadius: 0.2,
            offset: Offset(0.3, 4))
      ]
    ),);
  }
}