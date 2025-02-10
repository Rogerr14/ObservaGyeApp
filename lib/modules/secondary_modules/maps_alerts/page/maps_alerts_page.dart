import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:observa_gye_app/modules/alerts_detail/page/alerts_detail_page.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_alerts/model/alerts_model.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_observation/model/observations_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/services/alerts_services.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:observa_gye_app/shared/widget/layout_generic.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class MapsAlertsPage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> keyDismiss;
  const MapsAlertsPage({super.key, required this.keyDismiss});

  @override
  State<MapsAlertsPage> createState() => _MapsAlertsPageState();
}

class _MapsAlertsPageState extends State<MapsAlertsPage> {
  final Completer<GoogleMapController> _controller = Completer();
  AlertsModel? alertsModel;
  late FunctionalProvider fp;
  Set<Marker> marker = {};

  CameraPosition location = const CameraPosition(
      target: LatLng(-2.1832355790582962, -80.01632771534288), zoom: 14.4746);

  @override
  void initState() {
    fp = Provider.of<FunctionalProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _getAlerts();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _getAlerts() async {
    final response = await AlertsServices().getAlerts(context, id_estado: '3');
    if (!response.error) {
      if (response.data!.alertas.isNotEmpty) {
        alertsModel = response.data;
        marker = alertsModel!.alertas
            .map(
              (alerts) => Marker(
                draggable: true,
                flat: true,
                  markerId: MarkerId(
                    alerts.idAlerta.toString(),
                  ),
                  position: LatLng(
                    double.parse(alerts.coordenadaLatitud),
                    double.parse(alerts.coordenadaLongitud),
                  ),
                  onTap: () {
                    final keyAlertDetail = GlobalHelper.genKey();
                    fp.addPage(
                        key: keyAlertDetail,
                        content: AlertsDetailPage(
                          key: keyAlertDetail,
                            keyPage: keyAlertDetail,
                            alerta: alerts));
                  }),
            )
            .toSet();
            setState(() {
              
            });
      }else{
         final keyAlertsEmpity = GlobalHelper.genKey();
        fp.showAlert(
          key: keyAlertsEmpity,
          content: AlertGeneric(
            content: NoExistInformation(
              message: 'No existen Alertas',
              function: () {
                fp.dismissAlert(key: keyAlertsEmpity);
                fp.dismissPage(key: widget.keyDismiss);
              },
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutPageGeneric(
        keyDismiss: widget.keyDismiss,
        nameInterceptor: 'MapsAlerts',
        requiredStack: false,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextTitleWidget(
                  title: 'Mapa de Alertas',
                  size: 20,
                ),
              ),
            ),
            Flexible(
              child: GoogleMap(
                markers: marker,
                mapType: MapType.normal,
                initialCameraPosition: location,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            )
          ],
        ));
  }
}
