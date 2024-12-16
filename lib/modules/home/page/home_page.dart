import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/widget/layout.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutWidget(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
                alignment: Alignment.centerLeft,
                child: TextTitleWidget(title: 'Ultimas Observaciones')),
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
                child: TextTitleWidget(title: 'Estadisticas')),
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
                        size),
                    _cardWidget(
                        'Alertas',
                        TextTitleWidget(
                          title: '350',
                          size: 30,
                        ),
                        size),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _cardWidget(
                        'Identificaciones',
                        TextTitleWidget(
                          title: '1,500',
                          size: 30,
                        ),
                        size),
                    _cardWidget(
                        'Mapa', SvgPicture.asset(AppTheme.iconMap), size),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget _cardWidget(String title, Widget child, Size size) {
    return SizedBox(
      width: size.width * 0.35,
      height: size.height * 0.2,
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
    );
  }
}
