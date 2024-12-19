import 'package:flutter/material.dart';

class CardListaWidget extends StatefulWidget {
  final String ulrImagen;
  final String title;
  final String subtitle;
  final Function() onPressed;
  const CardListaWidget({super.key, required this.ulrImagen, required this.title, required this.subtitle, required this.onPressed});

  @override
  State<CardListaWidget> createState() => _CardListaWidgetState();
}

class _CardListaWidgetState extends State<CardListaWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Column(
          
        )
      ],
    );
  }
}