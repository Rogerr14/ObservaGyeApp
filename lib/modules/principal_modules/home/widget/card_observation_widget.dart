import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/observation_detail/page/observation_detail_page.dart';

import 'package:observa_gye_app/modules/secondary_modules/general_observation/model/observations_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/responsive.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class CardObservationWidget extends StatefulWidget {
  final Observaciones observation;
  
  const CardObservationWidget({
    super.key,
    required this.observation,
  });

  @override
  State<CardObservationWidget> createState() => _CardObservationWidgetState();
}

class _CardObservationWidgetState extends State<CardObservationWidget> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 120,
      child: Card(
        color: AppTheme.grayShadow,
        elevation: 1,
        shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: AppTheme.primaryColor, width: 0.5)),
        child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: responsive.wp(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextTitleWidget(
                          title: widget.observation.nombreComun!,
                          size: responsive.dp(1.98),
                        ),
                        
                        TextTitleWidget(
                          title: widget.observation.nombreCientifico!,
                          size: responsive.dp(1.6),
                        ),
                        TextSubtitleWidget(
                          subtitle: DateFormat('yyyy-MM-dd')
                              .format(widget.observation.fechaObservacion),
                          size: responsive.wp(4),
                        ),
                        
                      ],
                    ),
                    FilledButtonWidget(
                      text: 'Ver más',
                      width: responsive.wp(30),
                      height: responsive.hp(5),
                      onPressed: (){
                        final keyObservationPage = GlobalHelper.genKey();
                        final fp = Provider.of<FunctionalProvider>(context, listen: false);
                      fp.addPage(
                          key: keyObservationPage,
                          content:
                              ObservationDetailPage(
                                key: keyObservationPage,
                                keyPage: keyObservationPage,
                                observation: widget.observation,));
                      },
                    )
                  ],
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      height: responsive.hp(20),
                      width: responsive.wp(30),
                      widget.observation.imagen1,
                      fit: BoxFit.cover,
                    ))
              ],
            ),
          ),
      ),
    );
  }
}
