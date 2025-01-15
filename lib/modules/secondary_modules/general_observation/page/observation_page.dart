import 'package:flutter/material.dart';
import 'package:observa_gye_app/modules/principal_modules/my_aports/widget/list_widget.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_alerts/widget/list_widget.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_observation/model/observations_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/services/observtion_services.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:observa_gye_app/shared/widget/card_lista_widget.dart';
import 'package:observa_gye_app/shared/widget/layout.dart';
import 'package:observa_gye_app/shared/widget/layout_generic.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class ObservationPage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> keyDismiss;
  const ObservationPage({super.key, required this.keyDismiss});

  @override
  State<ObservationPage> createState() => _ObservationPageState();
}

class _ObservationPageState extends State<ObservationPage> {
late FunctionalProvider fp;
Observations? observations;

@override
void initState() {
  fp = Provider.of<FunctionalProvider>(context, listen: false);
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getObservations();
    },);
  super.initState();
  
}

@override
void dispose() {
  
  super.dispose();
}


_getObservations() async {
    final response = await ObservationServices().getObservations(context, estado: true);
    if (!response.error) {
      if (response.data!.observaciones.isNotEmpty) {
        observations = response.data;
        setState(() {});
      } else {
        final keyAlertsEmpity = GlobalHelper.genKey();
        fp.showAlert(
          key: keyAlertsEmpity,
          content: AlertGeneric(
            content: NoExistInformation(
              message: 'No existen observaciones',
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
        requiredStack: false,
        nameInterceptor: 'ObservationPage',
        child:  Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextTitleWidget(title: 'Observaciones', size: 20,),
              ),
            ),
            SizedBox(height: 30,),
            // ListView(
            //   padding: EdgeInsets.all(8),
            //   children: [
            //     CardListaWidget(ulrImagen: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Psittacus_erithacus_qtl1.jpg/1200px-Psittacus_erithacus_qtl1.jpg', title: 'jola', subtitle: 'ss', onPressed: (){}),
            //   ],
            // )
            if(observations != null)
              Expanded(
                child: ListView.builder(
                   itemCount: observations!.observaciones.length,
                  itemBuilder: (context, index) => ListWidgetObservations(observations: observations!.observaciones[index],),)
              ),
            
          ],
        ));
  }
}
