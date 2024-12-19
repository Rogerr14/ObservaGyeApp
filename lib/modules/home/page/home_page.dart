import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/home/page/submodules/alert_users/page/alerts_page.dart';
import 'package:observa_gye_app/modules/home/page/submodules/observation_users/page/observation_page.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/layout.dart';
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
    final size = MediaQuery.of(context).size;
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return LayoutWidget(
        child: Padding(
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
            SizedBox(
              height: 20,
            ),
            FlutterCarousel(
              items: [1, 2, 3, 4, 5].map((i) {
                return Container(
                    width: size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: AppTheme.grayShadow,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: AppTheme.primaryColor, width: 2)),
                    child: Text(
                      'text $i',
                      style: TextStyle(fontSize: 16.0),
                    ));
              }).toList(),
              options: FlutterCarouselOptions(
                height: size.height * 0.2,
                showIndicator: true,
                slideIndicator: CircularSlideIndicator(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextTitleWidget(title: 'Estadisticas'),
                )),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _cardWidget(
                        'Observaciones',
                        TextTitleWidget(
                          title: '2,500',
                          size: 30,
                        ),
                        size,
                        (){
                          final keyObservatioPage = GlobalHelper.genKey();
                          fp.addPage(key: keyObservatioPage, content: ObservationPage(
                            key: keyObservatioPage,
                            keyDismiss: keyObservatioPage),
                            );
                        }),
                    _cardWidget(
                        'Alertas',
                        TextTitleWidget(
                          title: '350',
                          size: 30,
                        ),
                        size, (){
                          final keyAlertPage = GlobalHelper.genKey();
                          fp.addPage(key: keyAlertPage, content: AlertsPage(key: keyAlertPage,keyDismiss: keyAlertPage));
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                _cardWidget(
                    'Mapa', SvgPicture.asset(AppTheme.iconMap), size, (){
                      final keyMapPage = GlobalHelper.genKey();
                    })
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget _cardWidget(String title, Widget child, Size size, Function() onTap) {
    return SizedBox(
      width: size.width * 0.35,
      height: size.height * 0.15,
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: AppTheme.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(10)),
          color: AppTheme.grayShadow,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [TextTitleWidget(title: title), child],
            ),
          ),
        ),
      ),
    );
  }
}
