import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
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
    final responsive = Responsive(context);
    final size = MediaQuery.of(context).size;
    return Card(
        color: AppTheme.grayShadow,
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: AppTheme.primaryColor, width: 0.5)),
        child: SizedBox(
          width: size.width,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: responsive.wp(5), vertical: responsive.hp(2)),
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
                          size: responsive.wp(5),
                        ),
                        TextSubtitleWidget(
                          subtitle: DateFormat('yyyy-MM-dd')
                              .format(widget.dateObservation),
                          size: responsive.wp(4),
                        ),
                        TextTitleWidget(
                          title: widget.userObservation,
                          size: responsive.wp(4),
                        ),
                      ],
                    ),
                    FilledButtonWidget(
                      text: 'Ver más',
                      width: responsive.wp(25),
                      height: responsive.hp(3),
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
