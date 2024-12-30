import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:observa_gye_app/shared/widget/layout_generic.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class MapsObservationPage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> keyDismiss;
  const MapsObservationPage({super.key, required this.keyDismiss});

  @override
  State<MapsObservationPage> createState() => _MapsObservationPageState();
}

class _MapsObservationPageState extends State<MapsObservationPage> {
  final Completer<GoogleMapController> _controller = Completer();

  CameraPosition location = const CameraPosition(
      target: LatLng(-2.1832355790582962, -80.01632771534288), zoom: 14.4746);
  @override
  Widget build(BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return LayoutPageGeneric(
      keyDismiss: widget.keyDismiss,
      nameInterceptor: 'MapObservation',
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
                title: 'Mapa de Observaciones',
                size: 20,
              ),
            ),
          ),
          Flexible(
            child: GoogleMap(
              markers: {
                Marker(
                    markerId: const MarkerId('Mall del Sol'),
                    position: const LatLng(-2.181162165689552, -80.01526236854193),
                    infoWindow: const InfoWindow(
                        title: 'Loro titi', snippet: 'Loro titi'),
                    onTap: () {
                      final keyalert = GlobalHelper.genKey();
                      fp.showAlert(
                          key: keyalert,
                          content: AlertGeneric(content: Container(), dismissable: true, keyToClose: keyalert,),
                          closeAlert: true);
                    }),
              },
              mapType: MapType.normal,
              initialCameraPosition: location,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          )
        ],
      ),
    );
  }
}
