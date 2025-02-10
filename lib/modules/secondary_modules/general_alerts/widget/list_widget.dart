import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/observation_detail/page/observation_detail_page.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_alerts/model/alerts_model.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_observation/model/observations_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class ListWidgetObservations extends StatefulWidget {
  final bool isGeneral;
  final Observaciones observations;
  const ListWidgetObservations({super.key, this.isGeneral = true, required this.observations});

  @override
  State<ListWidgetObservations> createState() => _ListWidgetObservationsState();
}

class _ListWidgetObservationsState extends State<ListWidgetObservations> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        final keyObservationDetail = GlobalHelper.genKey();
        fp.addPage(
            key: keyObservationDetail,
            content: ObservationDetailPage(
              observation: widget.observations,
              isGeneral: widget.isGeneral,
              keyPage: keyObservationDetail,
              key: keyObservationDetail,
            ));
      },
      child: Card(
        color: AppTheme.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.observations.imagen1,
                    height: responsive.hp(10),
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextTitleWidget(
                      title: widget.observations.nombreComun ?? widget.observations.nombreTemporal!,
                      showShadow: false,
                    ),
                    TextSubtitleWidget(subtitle:  DateFormat('dd/MM/yyyy').format(widget.observations.fechaObservacion)),
                  Visibility(
                        visible: !widget.isGeneral,
                        child: _statePublish(widget.observations.idEstado, responsive)),
                    Visibility(
                        visible: widget.isGeneral,
                        child: TextSubtitleWidget(
                          subtitle: widget.observations.usuario,
                        ))
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: 24,
                color: AppTheme.primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }




  _statePublish(String status, Responsive responsive) {
    switch (status) {
      case "1":
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.yellow, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle: 'Enviado')),
        );

      case "2":
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.green, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle: 'Aprobada')),
        );
      
       case "3":
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.red, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle: 'Rechazada')),
        );
      default:
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.error, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle: 'Rechazada')),
        );
    }
  }




}

