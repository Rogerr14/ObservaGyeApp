import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_alerts/model/alerts_model.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/widget/layout_generic.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class AlertsDetailPage extends StatefulWidget {
  final Alerta alerta;
  final GlobalKey<State<StatefulWidget>> keyPage;
  final bool isGeneral;
  const AlertsDetailPage({super.key, required this.keyPage, required this.isGeneral, required this.alerta});

  @override
  State<AlertsDetailPage> createState() => _AlertsDetailPageState();
}

class _AlertsDetailPageState extends State<AlertsDetailPage> {
  List<String> imagenes = [];
 final Completer<GoogleMapController> _controller = Completer();
  late CameraPosition location; 
  @override
  void initState() {
    _imagenes();
    location = CameraPosition(
      target: LatLng(double.parse(widget.alerta.coordenadaLatitud), double.parse(widget.alerta.coordenadaLatitud)), zoom: 14.4746);
    
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _imagenes(){
    if(widget.alerta.imagen1 != '') imagenes.add(widget.alerta.imagen1); 
    if(widget.alerta.imagen2 != '') imagenes.add(widget.alerta.imagen2); 
    if(widget.alerta.imagen3 != '') imagenes.add(widget.alerta.imagen3); 
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsive = Responsive(context);
    return LayoutPageGeneric(
      requiredStack: false,
      keyDismiss: widget.keyPage,
      nameInterceptor: 'ObservationDetail',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTitleWidget(
                title: widget.alerta.tipoAlerta,
                size: 20,
              ),
              
              Visibility(
                          visible: !widget.isGeneral,
                          child: _statePublish(int.parse(widget.alerta.idEstado), responsive)),
              const SizedBox(
                height: 20,
              ),
              FlutterCarousel(
                items: imagenes.map((imagen) => ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      imagen,
                      height: 10,
                      width: responsive.width,
                      fit: BoxFit.contain,
                    ),
                  ),).toList()
              ,
                options: FlutterCarouselOptions(
                  showIndicator: true,
                  height: responsive.hp(30),
                  autoPlay: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextTitleWidget(
                title: 'Ubicación',
                size: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: size.height * 0.2,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: AppTheme.primaryColor, width: 0.5)),
                child: GoogleMap(
                  // liteModeEnabled: true,
                  scrollGesturesEnabled: false,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  markers: {
                    Marker(
                      markerId: const MarkerId('Observacion'),
                      position:
                         LatLng(double.parse(widget.alerta.coordenadaLatitud), double.parse(widget.alerta.coordenadaLongitud)),
                      infoWindow:  InfoWindow(
                          title: widget.alerta.tipoAlerta, snippet: widget.alerta.nombreEstado),
                      // onTap: () {
                      //   final keyalert = GlobalHelper.genKey();
                      //   fp.showAlert(
                      //       key: keyalert,
                      //       content: AlertGeneric(content: Container(), dismissable: true, keyToClose: keyalert,),
                      //       closeAlert: true);
                      // },
                    ),
                  },
                  mapType: MapType.normal,
                  initialCameraPosition: location,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextTitleWidget(
                title: 'Datos Adicionales',
                size: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  TextTitleWidget(title: 'Fecha: '),
                  TextSubtitleWidget(subtitle: widget.alerta.fechaCreado.toString())
                ],
              ),
              Visibility(
                visible: widget.isGeneral,
                child: Row(
                  children: [
                    TextTitleWidget(title: 'Usuario: '),
                    TextSubtitleWidget(subtitle: widget.alerta.usuario)
                  ],
                ),
              ),
              Wrap(
                children: [
                  TextTitleWidget(title: 'Nota: '),
                  TextSubtitleWidget(
                      subtitle:
                          widget.alerta.descripcion)
                ],
              ),
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
          child: Center(child: TextSubtitleWidget(subtitle: 'Enviado')),
        );

      case 2:
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.green, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle: 'Aprobado')),
        );
      case 3:
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.red, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle: 'Rechazado')),
        );

      default:
        return Container(
          width: responsive.wp(25),
          height: responsive.hp(3),
          decoration: BoxDecoration(
              color: AppTheme.error, borderRadius: BorderRadius.circular(5)),
          child: Center(child: TextSubtitleWidget(subtitle: 'Rechazado')),
        );
    }
  }
}