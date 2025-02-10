import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/alerts_detail/page/alerts_detail_page.dart';
import 'package:observa_gye_app/modules/observation_detail/page/observation_detail_page.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_alerts/model/alerts_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class ListWidget extends StatefulWidget {
  final bool isGeneral;
  final Alerta alerta;
  const ListWidget({super.key, this.isGeneral = true, required this.alerta});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        final keyAlertDetailPage = GlobalHelper.genKey();
        fp.addPage(
            key: keyAlertDetailPage,
            content: AlertsDetailPage(
              alerta: widget.alerta,
              isGeneral: widget.isGeneral,
              keyPage: keyAlertDetailPage,
              key: keyAlertDetailPage,
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
                  widget.alerta.imagen1,
                  height: responsive.height *0.1,
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    
                    return child;
                  },
                  
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextTitleWidget(
                      title: widget.alerta.tipoAlerta,
                      showShadow: false,
                    ),
                    TextSubtitleWidget(
                        subtitle: widget.alerta.fechaCreado.toString()),
                    Visibility(
                        visible: !widget.isGeneral,
                        child: _statePublish(
                            int.parse(widget.alerta.idEstado), responsive)),
                    Visibility(
                        visible: widget.isGeneral,
                        child: TextSubtitleWidget(
                          subtitle: widget.alerta.usuario,
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

  _statePublish(int status, Responsive responsive) {
    switch (status) {
      case 1:
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.yellow, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle:widget.alerta.nombreEstado)),
        );

      case 2:
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.green, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle: widget.alerta.nombreEstado)),
        );
      case 3:
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.red, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle: widget.alerta.nombreEstado)),
        );

      default:
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.error, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle: 'Cerrada')),
        );
    }
  }
}
