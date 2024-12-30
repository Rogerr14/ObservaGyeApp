import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:observa_gye_app/modules/observation_detail/page/observation_detail_page.dart';
import 'package:observa_gye_app/modules/principal_modules/home/widget/card_observation_widget.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
             Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextTitleWidget(title: 'Ultimas Observaciones', size: responsive.isTablet ? responsive.wp(7.2) : responsive.wp(5) ,),
                )),
            const SizedBox(
              height: 20,
            ),
            FlutterCarousel(
              
              items: [
                CardObservationWidget(
                  nameObservation: 'Loro Africano',
                  userObservation: 'JPerez',
                  dateObservation: DateTime.now(),
                  urlImageObservation:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Amazona_autumnalis_-Jurong_BirdPark-8b.jpg/220px-Amazona_autumnalis_-Jurong_BirdPark-8b.jpg',
                  onPress: () {
                    final fp =
                        Provider.of<FunctionalProvider>(context, listen: false);
                    final keyObservationPage = GlobalHelper.genKey();
                    fp.addPage(
                        key: keyObservationPage,
                        content:
                            ObservationDetailPage(
                              key: keyObservationPage,
                              keyPage: keyObservationPage));
                  },
                ),
                CardObservationWidget(
                  nameObservation: 'Loro Africano',
                  userObservation: 'JPerez',
                  dateObservation: DateTime.now(),
                  urlImageObservation:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Amazona_autumnalis_-Jurong_BirdPark-8b.jpg/220px-Amazona_autumnalis_-Jurong_BirdPark-8b.jpg',
                  onPress: () {
                    final fp =
                        Provider.of<FunctionalProvider>(context, listen: false);
                    final keyObservationPage = GlobalHelper.genKey();
                    fp.addPage(
                        key: keyObservationPage,
                        content:
                            ObservationDetailPage(
                              key: keyObservationPage,
                              keyPage: keyObservationPage));
                  },
                ),
                CardObservationWidget(
                  nameObservation: 'Loro Africano',
                  userObservation: 'JPerez',
                  dateObservation: DateTime.now(),
                  urlImageObservation:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Amazona_autumnalis_-Jurong_BirdPark-8b.jpg/220px-Amazona_autumnalis_-Jurong_BirdPark-8b.jpg',
                  onPress: () {
                    final fp =
                        Provider.of<FunctionalProvider>(context, listen: false);
                    final keyObservationPage = GlobalHelper.genKey();
                    fp.addPage(
                        key: keyObservationPage,
                        content:
                            ObservationDetailPage(
                              key: keyObservationPage,
                              keyPage: keyObservationPage));
                  },
                ),
              ],
              options: FlutterCarouselOptions(
                height: responsive.hp(22),
                showIndicator: false,
                // slideIndicator: CircularSlideIndicator(),
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
                       '2,500',
                      'Observaciones',
                       responsive
                    ),
                    _cardWidget(
                      '350',
                      'Alertas',
                       responsive
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _cardWidget(
                  '2,300',
                  'Usuarios',
                  responsive
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _cardWidget(String quantity, String title,  Responsive responsive) {
    return SizedBox(
      width: responsive.wp(40),
      height: responsive.hp(15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextTitleWidget(
                    title: quantity,
                    size: responsive.wp(10),
                  ),
            TextTitleWidget(
              title: title,
              size: responsive.wp(4.5),
            ),
          ],
        ),
      ),
    );
  }
}
