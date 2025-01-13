import 'package:flutter/material.dart';
import 'package:observa_gye_app/modules/principal_modules/my_aports/widget/list_widget.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_alerts/model/alerts_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/services/alerts_services.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
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

  @override
  void initState() {
    fp = Provider.of<FunctionalProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getAlerts();
    },);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getAlerts() async {
    final response = await AlertsServices().getAlerts(context);
    if (!response.error) {
      if (response.data!.alertas.isNotEmpty) {
        alertsModel = response.data;
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
            SizedBox(
              height: 30,
            ),
            if (alertsModel != null)
            Expanded(
              child: ListView.builder(
                itemCount: alertsModel!.alertas.length,
                itemBuilder: (context, index) => ListWidget(alerta: alertsModel!.alertas[index], ),
              ),
            ),
          ],
        ));
  }
}
