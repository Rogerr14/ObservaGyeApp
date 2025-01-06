
import 'package:flutter/material.dart';
import 'package:observa_gye_app/modules/security/login/model/user_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/secure_storage.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';

class FunctionalProvider extends ChangeNotifier {
  List<Widget> pages = [];
  List<Widget> alerts = [];


  ButtonNavigatorBarItem buttonNavigatorBarItem = ButtonNavigatorBarItem.iconMenuHome;
  // List<Widget> alertLoading = [];
  bool darkMode = false;

selectIconBottomNavigationBarItem(){
    return buttonNavigatorBarItem;
  }

  setIconBottomNavigationBarItem(ButtonNavigatorBarItem value){
    buttonNavigatorBarItem = value;
    notifyListeners();
  }



  showAlert(
      {required GlobalKey key,
      required Widget content,
      bool closeAlert = false,
      bool animation = true,
      double padding = 20}) {
    final newAlert = Container(
      key: key,
      color: Colors.transparent,
      child: AlertTemplate(
          content: content,
          keyToClose: key,
          dismissAlert: closeAlert,
          animation: animation,
          padding: padding),
    );
    alerts.add(newAlert);

    notifyListeners();
  }

  // showAlert(
  //     {required GlobalKey key,
  //     required Widget content,
  //     bool closeAlert = false,
  //     bool animate = true,
  //     double padding = 20}) {
  //   final newAlert = Container(
  //     key: key,
  //     color: AppTheme.transparent,
  //     child: AlertTemplate(
  //       content: content,
  //       keyToClose: key,
  //       dismissAlert: closeAlert,
  //       animation: animate,
  //       padding: padding,
  //     ),
  //   );

  //   alerts.add(newAlert);
  //   notifyListeners();
  // }

  // showAlertLoading(
  //     {required GlobalKey key,
  //     required Widget content,
  //     bool closeAlert = false,
  //     bool animation = true}) {
  //   final newAlert = Container(
  //     key: key,
  //     color: AppTheme.transparent,
  //     child: AlertTemplate(
  //       content: content,
  //       keyToClose: key,
  //       dismissAlert: closeAlert,
  //       animation: animation,
  //     ),
  //   );

  // alertLoading.add(newAlert);
  //   alerts.add(newAlert);
  //   notifyListeners();
  // }

  addPage({required GlobalKey key, required Widget content}) {
    pages.add(content);
    notifyListeners();
  }

  clearAllAlert() {
    pages = [];
    alerts = [];
    notifyListeners();
  }

  dismissPage({required GlobalKey key}) {
    pages.removeWhere((page) => key == page.key);
    notifyListeners();
  }

  dismissAlert({required GlobalKey key}) {
    alerts.removeWhere((alert) => key == alert.key);
    notifyListeners();
  }

  // dismissAlertLoading({required GlobalKey key}) {
  //   // alertLoading.removeWhere((alert) => key == alert.key);
  //   alerts.removeWhere((alert) => key == alert.key);
  //   notifyListeners();
  // }
}
