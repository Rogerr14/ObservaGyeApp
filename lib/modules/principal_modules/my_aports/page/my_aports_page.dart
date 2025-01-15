import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/principal_modules/my_aports/widget/my_alerts_page.dart';
import 'package:observa_gye_app/modules/principal_modules/my_aports/widget/my_observation_page.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_alerts/model/alerts_model.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_observation/model/observations_model.dart';
import 'package:observa_gye_app/modules/security/login/model/user_model.dart';
import 'package:observa_gye_app/shared/helpers/secure_storage.dart';
import 'package:observa_gye_app/shared/services/alerts_services.dart';
import 'package:observa_gye_app/shared/services/observtion_services.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class MyAportsPage extends StatefulWidget {
  const MyAportsPage({super.key});

  @override
  State<MyAportsPage> createState() => _MyAportsPageState();
}

class _MyAportsPageState extends State<MyAportsPage>
    with SingleTickerProviderStateMixin {
  int _currentTab = 0;
  late TabController _tabController;
  UserModel? userModel;
  Observations? observations;
  AlertsModel? alertsModel;

  @override
  void initState() {
    super.initState();
        _getMyReports();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    },);
    _tabController = TabController(
        length: 2,
        vsync: this,
        animationDuration: const Duration(milliseconds: 500));
  }

  void _setCurrentTab(int v) {
    if (v != _currentTab) {
      _tabController.index = v;
      _currentTab = v;
      setState(() {});
    }
  }

  _getMyReports()async{
    userModel = await SecureStorage().getUserData();
    if(userModel != null){
      String user_id = userModel!.idUser;
    final responseObservation = await ObservationServices().getObservations(context, user_id: user_id,);
    final responseAlerts = await AlertsServices().getAlerts(context, id_user: user_id);
      if(!responseObservation.error){
        observations = responseObservation.data!;
      }
      if(!responseAlerts.error){
        alertsModel = responseAlerts.data!;
      }

    }
    setState(() {
      
    });

  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: Column(
        children: [
          Container(
            color: AppTheme.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _TabPage(
                  label: 'Mis Observaciones',
                  isActive: _currentTab == 0,
                  onPress: () {
                    _setCurrentTab(0);
                  },
                ),
                _TabPage(
                  label: 'Mis Alertas',
                  isActive: _currentTab == 1,
                  onPress: () {
                    _setCurrentTab(1);
                  },
                ),
              ],
            ),
          ),
           Flexible(
            fit: FlexFit.loose,
             child: TabBarView(
               clipBehavior: Clip.antiAlias,
               physics: const NeverScrollableScrollPhysics(),
               controller: _tabController,
               children: [
                   observations != null
                      ? MyObservationPage(
                          observaciones: observations!.observaciones,
                        )
                      : Align(
                          alignment: Alignment.center,
                          child:
                              TextTitleWidget(title: 'No has creado observaciones'),
                        ),
                  alertsModel != null
                      ? MyAlertsPage(
                          alertas: alertsModel!.alertas,
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: TextTitleWidget(title: 'No has creado alertas'),
                        ),
               ],
             ),
           ),
        ],
      ),
    );
  }
}

class _TabPage extends StatelessWidget {
  final String label;
  final bool isActive;
  final Function() onPress;
  const _TabPage(
      {required this.label, required this.isActive, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPress,
      child: Container(
        width: size.width * 0.5,
        // height: 200,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 3,
                    color: isActive ? AppTheme.primaryColor : AppTheme.white))),
        child: Center(
          child: TextSubtitleWidget(
            subtitle: label,
          ),
        ),
      ),
    );
  }
}
