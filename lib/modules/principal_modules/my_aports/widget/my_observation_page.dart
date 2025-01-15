import 'package:flutter/material.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_alerts/widget/list_widget.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_observation/model/observations_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class MyObservationPage extends StatefulWidget {
  List<Observaciones> observaciones;
  MyObservationPage({super.key, this.observaciones = const []});

  @override
  State<MyObservationPage> createState() => _MyObservationPageState();
}

class _MyObservationPageState extends State<MyObservationPage> {
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.builder(
              itemCount: widget.observaciones.length,
              itemBuilder: (context, index) => ListWidgetObservations(
                observations: widget.observaciones[index],
                isGeneral: false,
              ),
            )
          
    );
  }
}
