import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    super.key,
    this.onPressed,
    this.color = AppTheme.primaryColor,
    required this.text,
    this.fontWeight = FontWeight.w600, 
    this.fontSize = 17,
  });

  final void Function()? onPressed;
  final Color? color;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text,
          style: TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize, decoration: TextDecoration.underline, )),
    );
  }
}
