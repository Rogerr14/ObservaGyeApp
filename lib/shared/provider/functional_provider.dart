//import 'package:edeplus_docs/shared/widgets/alerts_template.dart';
import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';


class FunctionalProvider extends ChangeNotifier {
  List<Widget> alerts = [];
  List<Widget> alertLoading = [];
  String nameUser = '';
  String namesSurnames = '';
  // //? Se utilizara en paginas normales
  // AnimationController? alertController;
  // AnimationController? alertControllerContent;
  // //? Se utilizara en las Notificaciones
  // AnimationController? notificationController;

  showAlert({required GlobalKey key, required Widget content, bool closeAlert = false, bool animation = true, double padding = 20}) {
    //final keyAlert = GlobalHelper.genKey();

    final newAlert = Container(
      key: key,
      color: AppTheme.transparent,
      child: AlertTemplate(content: content, keyToClose: key, dismissAlert: closeAlert, animation: animation, padding: padding));
    alerts.add(newAlert);

    //alertLoading.add(const SizedBox());
    //alertLoading.add(newAlert);
    //debugPrint('total de alertas: ${alerts.length.toString()}');
    //debugPrint('total de alertLoading: ${alertLoading.length.toString()}');
    notifyListeners();
    //-----NO SIRVE LO DE ABAJO ------
    //  WidgetsBinding.instance.addPostFrameCallback((timeStamp) => {
    //    notifyListeners()
    //  });
  }

  showAlertLoading({required GlobalKey key, required Widget content, bool closeAlert = false, bool animation = true}) {
    //final keyAlert = GlobalHelper.genKey();

    final newAlert = Container(
      key: key,
      color: Colors.transparent,
      child: AlertTemplate(content: content, keyToClose: key, dismissAlert: closeAlert, animation: animation));
    alertLoading.add(newAlert);
    alerts.add(newAlert);
    //debugPrint('total de alertas: ${alertLoading.length.toString()}');
    notifyListeners();
    //-----NO SIRVE LO DE ABAJO ------
    //  WidgetsBinding.instance.addPostFrameCallback((timeStamp) => {
    //    notifyListeners()
    //  });
  }

  addPage({required GlobalKey key, required Widget content}) {
    // final newAlert = AlertTemplate(key: key, content: content);
    alerts.add(content);
    // debugPrint('total de alertas: ${alerts.length.toString()}');
    notifyListeners();
    //-----NO SIRVE LO DE ABAJO ------
    //  WidgetsBinding.instance.addPostFrameCallback((timeStamp) => {
    //    notifyListeners()
    //  });
  }

  // showNotification() {
  //   notificationController!.forward();
  // }

  // dismissNotification() {
  //   notificationController!.reverse();
  // }

  dismissAlert({required GlobalKey key}) {
    //debugPrint("MANDAR A BORRAR alert de: $key");
    alerts.removeWhere((alert) => key == alert.key);
    //alertLoading.removeWhere((alert) => key == alert.key);
    notifyListeners();
  }

  clearAllAlert() {
    alerts = [];
    notifyListeners();
  }

   dismissAlertLoading({required GlobalKey key}) {
    //debugPrint("MANDAR A BORRAR alert de: $key");
    alertLoading.removeWhere((alert) => key == alert.key);
    alerts.removeWhere((alert) => key == alert.key);
    notifyListeners();
  }

  saveUserName(String value){
    nameUser = value;
    notifyListeners();
  }

  String getUserName(){
    return nameUser;
  }

  saveNamesSurnames(String value){
    namesSurnames = value;
    notifyListeners();
  }

  String getNamesSurnames(){
    return namesSurnames;
  }
}
