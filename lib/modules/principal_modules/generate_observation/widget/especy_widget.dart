import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_observation/model/especies_model.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class EspecyWidget extends StatefulWidget {
  final Especy? especies;
  final String titleAlt;
  const EspecyWidget({super.key, this.especies,  this.titleAlt=''});

  @override
  State<EspecyWidget> createState() => _EspecyWidgetState();
}

class _EspecyWidgetState extends State<EspecyWidget> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppTheme.primaryColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              DottedBorder(
                radius: Radius.circular(200),
                child: SizedBox(
                  height: responsive.height * 0.1,
                  width: responsive.width * 0.15,
                  child:
                      (widget.especies != null && widget.especies!.imagen != '')
                          ? Image.network(widget.especies!.imagen)
                          : Center(
                              child: Icon(Icons.image),
                            ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextTitleWidget(
                    title: widget.especies != null
                        ? widget.especies!.nombreComun
                        : widget.titleAlt,
                    showShadow: false,
                  ),
                  Visibility(
                    visible: widget.especies != null,
                    child: TextTitleWidget(
                      title: widget.especies?.nombreCientifico ?? '',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
