import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class CardObservationWidget extends StatefulWidget {
  final String nameObservation;
  final String userObservation;
  final DateTime dateObservation;
  final String urlImageObservation;
  final Function() onPress;
  const CardObservationWidget({
    super.key,
    required this.nameObservation,
    required this.userObservation,
    required this.dateObservation,
    required this.urlImageObservation, required this.onPress,
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
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: AppTheme.primaryColor, width: 0.5)),
        child: SizedBox(
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextTitleWidget(
                          title: widget.nameObservation,
                          size: 20,
                        ),
                        TextTitleWidget(
                          title: widget.userObservation,
                          size: 15,
                        ),
                        TextSubtitleWidget(
                          subtitle: DateFormat('yyyy-MM-dd')
                              .format(widget.dateObservation),
                          size: 14,
                        ),
                      ],
                    ),
                    FilledButtonWidget(
                      text: 'Ver más',
                      width: 10,
                      height: 30,
                      onPressed: widget.onPress,
                    )
                  ],
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.urlImageObservation,
                      fit: BoxFit.contain,
                    ))
              ],
            ),
          ),
        ));
  }
}
