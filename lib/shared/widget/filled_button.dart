import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';

class FilledButtonWidget extends StatelessWidget {
  const FilledButtonWidget({
    super.key,
    required this.onPressed,
    this.color = AppTheme.primaryColor,
    this.colorText = AppTheme.secondaryColor,
    required this.text,
    this.width = double.infinity,
    this.height = 40,
    this.borderRadius = 25, 
    this.fontSize = 15,
  });

  final void Function() onPressed;
  final Color color;
  final Color colorText;
  final String text;
  final double width;
  final double height;
  final double borderRadius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          backgroundColor: color,
          minimumSize: Size(width, height)),
      onPressed: onPressed,
      child: Text(text,
          style: TextStyle(
              color: colorText, fontWeight: FontWeight.bold, fontSize: fontSize, letterSpacing: 0.9)),
    );
  }
}
