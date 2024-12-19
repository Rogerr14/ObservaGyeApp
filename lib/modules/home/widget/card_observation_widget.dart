
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class CardObservationWidget extends StatefulWidget {
  final String nameObservation;
  final String userObservation;
  final DateTime dateObservation;
  final String urlImageObservation;
  const CardObservationWidget({
    super.key,
    required this.nameObservation,
    required this.userObservation,
    required this.dateObservation,
    required this.urlImageObservation,
  });

  @override
  State<CardObservationWidget> createState() => _CardObservationWidgetState();
}

class _CardObservationWidgetState extends State<CardObservationWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
        color: AppTheme.grayShadow,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppTheme.primaryColor, width: 2)
        ),
        child: SizedBox(
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextTitleWidget(title: widget.nameObservation, size: 20,),
                    TextTitleWidget(title: widget.userObservation, size: 15,),
                    TextSubtitleWidget(subtitle: DateFormat('yyyy-MM-dd').format(widget.dateObservation), size: 14,),
                   
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(widget.urlImageObservation, fit: BoxFit.contain,))
              ],
            ),
          ),
        ));
  }
}
