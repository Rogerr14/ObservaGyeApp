import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/widget/layout.dart';
import 'package:observa_gye_app/shared/widget/layout_generic.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class ObservationDetailPage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> keyPage;
  const ObservationDetailPage({super.key, required this.keyPage});

  @override
  State<ObservationDetailPage> createState() => _ObservationDetailPageState();
}

class _ObservationDetailPageState extends State<ObservationDetailPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              Row(
                children: [
                  TextTitleWidget(
                    title: 'Nombre Comun: ',
                    size: 20,
                  ),
                  TextSubtitleWidget(
                    subtitle: 'Lorito Verde',
                    size: 20,
                  )
                ],
              ),
              FlutterCarousel(
                items: [
                  Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Amazona_autumnalis_-Jurong_BirdPark-8b.jpg/220px-Amazona_autumnalis_-Jurong_BirdPark-8b.jpg',
                    height: 20,
                  )
                ],
                options: FlutterCarouselOptions(showIndicator: false),
              ),
              const SizedBox(height: 20,),
              const TextTitleWidget(title: 'Ubicación', size: 20,),
              Container(
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primaryColor, width: 0.5)
                  
                ),
              ),
              const SizedBox(height: 20,),
              const TextTitleWidget(title: 'Datos Adicionales', size: 20,),
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
              TextSubtitleWidget(subtitle: 'sdasdsadsadsajdsakjdvbdvnldnlknkvnlkvnnc aodjosa dosajdoisajdojsaodjeojdoiejdoieaoi eoijdoiajdiajdoeio jeoij doija djdoisajd ois jdois jdoisa jdoisadsaj')
              
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
