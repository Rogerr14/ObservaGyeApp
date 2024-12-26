import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:observa_gye_app/modules/principal_modules/home/widget/card_observation_widget.dart';
import 'package:observa_gye_app/shared/widget/layout.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> widgets = [
    CardObservationWidget(
        nameObservation: 'Loro Africano',
        userObservation: 'JPerez',
        dateObservation: DateTime.now(),
        urlImageObservation:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Psittacus_erithacus_qtl1.jpg/1200px-Psittacus_erithacus_qtl1.jpg')
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SingleChildScrollView(
    child: Column(
      children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextTitleWidget(title: 'Ultimas Observaciones'),
            )),
        const SizedBox(
          height: 20,
        ),
        FlutterCarousel(
          items: widgets,
          options: FlutterCarouselOptions(
            height: size.height * 0.2,
            showIndicator: true,
            slideIndicator: CircularSlideIndicator(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextTitleWidget(title: 'Estadisticas'),
            )),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _cardWidget(
                  'Observaciones',
                  const TextTitleWidget(
                    title: '2,500',
                    size: 40,
                  ),
                  size,
                ),
                _cardWidget(
                  'Alertas',
                  const TextTitleWidget(
                    title: '350',
                    size: 40,
                  ),
                  size,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
                _cardWidget(
                  'Usuarios',
                  const TextTitleWidget(
                    title: '2,300',
                    size: 40,
                  ),
                  size,
                )
          ],
        )
      ],
    ),
          ),
        );
  }

  Widget _cardWidget(String title, Widget child, Size size) {
    return SizedBox(
      width: size.width * 0.35,
      height: size.height * 0.15,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
            TextTitleWidget(
              title: title,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
