import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:observa_gye_app/shared/widget/layout.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class AlertsPage extends StatefulWidget {
  // final GlobalKey<State<StatefulWidget>> keyDismiss;
  const AlertsPage({
    super.key,
  });

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  XFile? image;
  final ImagePicker picker = ImagePicker();
  @override
  void initState() {
    // _takePick();
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) {
    //     final fp = Provider.of<FunctionalProvider>(context, listen: false);
    //     final keyAlert = GlobalHelper.genKey();
    //     fp.showAlert(
    //         key: keyAlert,
    //         content: AlertGeneric(
    //           content: Text('hola'),
    //           dismissable: true,
    //           keyToClose: keyAlert,
    //         ));
    //   },
    // );
  }

  // _takePick() async {
  //   // image = await picker.pickImage(source: ImageSource.camera);
  //   await picker.pickMultiImage()
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextTitleWidget(
                    title: 'Alertas',
                    size: 20,
                  )))
        ],
      ),
    );
  }
}
