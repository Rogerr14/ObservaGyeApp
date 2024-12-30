import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/widget/layout.dart';
import 'package:observa_gye_app/shared/widget/layout_generic.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class ObservationDetailPage extends StatefulWidget {
  final bool isGeneral;
  final GlobalKey<State<StatefulWidget>> keyPage;
  const ObservationDetailPage({super.key, required this.keyPage,  this.isGeneral = true});

  @override
  State<ObservationDetailPage> createState() => _ObservationDetailPageState();
}

class _ObservationDetailPageState extends State<ObservationDetailPage> {
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition location = const CameraPosition(
      target: LatLng(-2.1832355790582962, -80.01632771534288), zoom: 14.4746);

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
                title: 'Loro Nariz Roja',
                size: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              FlutterCarousel(
                items: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Amazona_autumnalis_-Jurong_BirdPark-8b.jpg/220px-Amazona_autumnalis_-Jurong_BirdPark-8b.jpg',
                      height: 10,
                      width: responsive.width,
                      fit: BoxFit.contain,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Amazona_autumnalis_-Jurong_BirdPark-8b.jpg/220px-Amazona_autumnalis_-Jurong_BirdPark-8b.jpg',
                      height: 10,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Amazona_autumnalis_-Jurong_BirdPark-8b.jpg/220px-Amazona_autumnalis_-Jurong_BirdPark-8b.jpg',
                      height: 10,
                    ),
                  ),
                ],
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
                      markerId: const MarkerId('Mall del Sol'),
                      position:
                          const LatLng(-2.181162165689552, -80.01526236854193),
                      infoWindow: const InfoWindow(
                          title: 'Loro titi', snippet: 'Loro titi'),
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
                  TextSubtitleWidget(subtitle: '24/07/2024')
                ],
              ),
              Row(
                children: [
                  TextTitleWidget(title: 'Usuario: '),
                  TextSubtitleWidget(subtitle: 'JPerez')
                ],
              ),
              Wrap(
                children: [
                  TextTitleWidget(title: 'Nota: '),
                  TextSubtitleWidget(
                      subtitle:
                          'sdasdsadsadsajdsakjdvbdvnldnlknkvnlkvnnc aodjosa dosajdoisajdojsaodjeojdoiejdoieaoi eoijdoiajdiajdoeio jeoij doija djdoisajd ois jdois jdoisa jdoisadsaj')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
