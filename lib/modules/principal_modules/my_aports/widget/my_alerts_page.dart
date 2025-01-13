import 'package:flutter/material.dart';
import 'package:observa_gye_app/modules/principal_modules/my_aports/widget/list_widget.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_alerts/model/alerts_model.dart';

class MyAlertsPage extends StatefulWidget {
  List<Alerta> alertas;
   MyAlertsPage({super.key, this.alertas = const []});

  @override
  State<MyAlertsPage> createState() => _MyAlertsPageState();
}

class _MyAlertsPageState extends State<MyAlertsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.alertas.length,
      itemBuilder: (context, index) => ListWidget(isGeneral: false, alerta: widget.alertas[index],),
    );
   
  }
}
