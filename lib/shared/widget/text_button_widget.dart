import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    super.key,
    this.onPressed,
    this.color = AppTheme.primaryColor,
    required this.text,
    this.width = double.infinity,
    this.height = 40,
    this.borderRadius = 25,
  });

  final void Function()? onPressed;
  final Color? color;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w600, fontSize: 15)),
    );
  }
}
