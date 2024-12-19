import 'package:flutter/material.dart';
import 'package:observa_gye_app/shared/widget/layout.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';


class AlertsPage extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>> keyDismiss;
  const AlertsPage({super.key, required this.keyDismiss});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      keyDismiss: widget.keyDismiss,
      requiredStack: false,
      nameInterceptor: 'AlertPage',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,),
                child: TextTitleWidget(title: 'Alertas', size: 20,)))
          ],
        ),
      ));
  }
}