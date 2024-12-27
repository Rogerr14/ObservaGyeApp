import 'package:flutter/material.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class CardListaWidget extends StatefulWidget {
  final String ulrImagen;
  final String title;
  final String subtitle;
  final Function() onPressed;
  const CardListaWidget(
      {super.key,
      required this.ulrImagen,
      required this.title,
      required this.subtitle,
      required this.onPressed});

  @override
  State<CardListaWidget> createState() => _CardListaWidgetState();
}

class _CardListaWidgetState extends State<CardListaWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        widget.ulrImagen,
                        repeat: ImageRepeat.noRepeat,
                        height: 80,
                        fit: BoxFit.contain,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextTitleWidget(title: widget.title),
                        TextSubtitleWidget(subtitle: widget.subtitle)
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined))
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
