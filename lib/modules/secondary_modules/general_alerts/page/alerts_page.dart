import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:observa_gye_app/modules/principal_modules/generate_alert/model/type_alerts_model.dart';
import 'package:observa_gye_app/modules/principal_modules/my_aports/widget/list_widget.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_alerts/model/alerts_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/services/alerts_services.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:observa_gye_app/shared/widget/drop_down_button_widget.dart';
import 'package:observa_gye_app/shared/widget/filled_button.dart';
import 'package:observa_gye_app/shared/widget/layout_generic.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class AlertsPage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> keyDismiss;
  const AlertsPage({super.key, required this.keyDismiss});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  late FunctionalProvider fp;
  AlertsModel? alertsModel;
  List<Alerta> sublistAlert = [];
  List<DropdownMenuItem<String>> alertType = [];
  TypeAlertsModel? typeAlertsModel;
  String selectAlert = '';

  @override
  void initState() {
    fp = Provider.of<FunctionalProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getAlerts();
      _getTypesAlerts();
    },);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  _filterAlerts(){
    if(selectAlert != '0'){

    final idAlert =  typeAlertsModel!.tiposAlertas.firstWhere((element) => element.idTipoAlerta == selectAlert).tipoAlerta;
    // GlobalHelper.logger.w(jsonEncode(typeAlertsModel!.tiposAlertas));
    sublistAlert = alertsModel!.alertas.where((element) => element.tipoAlerta == idAlert).toList();
    GlobalHelper.logger.w(jsonEncode(sublistAlert));
    }else{
      sublistAlert = alertsModel!.alertas;
    }

    setState(() {
      
    });
  }

  _getAlerts() async {
    final response = await AlertsServices().getAlerts(context, id_estado: "3");
    if (!response.error) {
      if (response.data!.alertas.isNotEmpty) {
        alertsModel = response.data;
        sublistAlert = alertsModel!.alertas;
        setState(() {});
      } else {
        final keyAlertsEmpity = GlobalHelper.genKey();
        fp.showAlert(
          key: keyAlertsEmpity,
          content: AlertGeneric(
            content: NoExistInformation(
              message: 'No existen alertas',
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


  _getTypesAlerts() async {
    final response = await AlertsServices().getTypeAlerts(context);
    if (!response.error) {
      typeAlertsModel = response.data;
      if (typeAlertsModel != null) {
        // selectAlert = typeAlertsModel!.tiposAlertas.first.tipoAlerta;
        alertType = typeAlertsModel!.tiposAlertas
            .map(
              (alerta) => DropdownMenuItem(
                  value: alerta.idTipoAlerta,
                  child: TextSubtitleWidget(subtitle: alerta.tipoAlerta)),
            )
            .toList();
        alertType.add( DropdownMenuItem(
                  value:'0',
                  child: TextSubtitleWidget(subtitle: 'Todas')));
      }
    }
    GlobalHelper.logger.w('alertas ${alertType.length}');
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return LayoutPageGeneric(
        keyDismiss: widget.keyDismiss,
        requiredStack: false,
        nameInterceptor: 'AlertsPage',
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextTitleWidget(
                  title: 'Alertas',
                  size: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child:  DropDownButtonWidget(
                        hint: 'Filtrar por Alerta',
                        validator: (value) {
                          if (value == null) {
                            return 'Seleccione una opcion';
                          }
                          return null;
                        },
                        items: alertType,
                        onChanged: (value) {
                          selectAlert = value!;
                          _filterAlerts();
                          GlobalHelper.logger.w(value);
                          setState(() {});
                        },
                      ),
            ),
            SizedBox(
              height: 30,
            ),
            if (alertsModel != null)
            Expanded(
              child: ListView.builder(
                itemCount: sublistAlert.length,
                itemBuilder: (context, index) => ListWidget(alerta: sublistAlert[index],isGeneral: false, ),
              ),
            ),
          ],
        ));
  }
}
