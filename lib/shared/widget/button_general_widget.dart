import 'package:flutter/material.dart';

class ButtonGeneralWidget extends StatelessWidget {
  final String nameButton;
  final Color textColor;
  final Icon? icon;

  final Color backgroundColor;
  final void Function()? onPressed;

  final double height;
  final double width;

  const ButtonGeneralWidget(
      {super.key,
      required this.nameButton,
      required this.backgroundColor,
      required this.height,
      required this.width,
      required this.textColor,
      required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide.none,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ?
              icon!
              : const SizedBox(),
            Text(
              nameButton,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                color: textColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
