import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/principal_modules/generate_observation/page/generate_observation_page.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_alerts/page/alerts_page.dart';
import 'package:observa_gye_app/modules/secondary_modules/general_observation/page/observation_page.dart';
import 'package:observa_gye_app/modules/secondary_modules/map_observation/page/maps_observation_page.dart';
import 'package:observa_gye_app/modules/secondary_modules/profile/page/profile_page.dart';
import 'package:observa_gye_app/modules/security/login/model/user_model.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/helpers/secure_storage.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_template.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';
import 'package:provider/provider.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key, required this.controller});

  final ZoomDrawerController controller;
  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  late FunctionalProvider fp;
  UserModel? userModel;

  @override
  void initState() {
     fp = Provider.of<FunctionalProvider>(context, listen: false);
     _getData();
    // TODO: implement initState
    super.initState();
  }

  _getData()async{
    userModel = await SecureStorage().getUserData(); 
  }



  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 90, 0, 20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    final keyUserPage = GlobalHelper.genKey();
                    fp.addPage(
                        key: keyUserPage,
                        content: ProfilePage(
                            key: keyUserPage, keyDismiss: keyUserPage));
                    await widget.controller.close!();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          AppTheme.iconUser,
                          height: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextTitleWidget(
                              title: fp.getUserName(),
                              // title: userModel != null ? '${userModel!.name.toUpperCase()} ${userModel!.lastName.toUpperCase()}': '',
                              color: AppTheme.white,
                              showShadow: false,
                            ),
                            const TextSubtitleWidget(
                              subtitle: 'Ver perfil',
                              color: AppTheme.white,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                _optionMenu(
                    icon: Icons.remove_red_eye_sharp,
                    titleOption: 'OBSERVACIONES GENERALES',
                    onPressed: () async {
                      final keyObservation = GlobalHelper.genKey();
                      fp.addPage(
                          key: keyObservation,
                          content: ObservationPage(
                            key: keyObservation,
                            keyDismiss: keyObservation,
                          ));
                      await widget.controller.close!();
                    }),
                const Divider(),
                _optionMenu(
                    icon: Icons.warning_rounded,
                    titleOption: 'ALERTAS GENERALES',
                    onPressed: () async {
                      final keyAlerts = GlobalHelper.genKey();
                      fp.addPage(
                          key: keyAlerts,
                          content: AlertsPage(
                            key: keyAlerts,
                            keyDismiss: keyAlerts,
                          ));
                      await widget.controller.close!();
                    }),
                const Divider(),
                _optionMenu(
                  icon: Icons.map_sharp,
                  titleOption: 'MAPA DE OBSERVACIONES',
                  onPressed: () async {
                    final keyMapObservation = GlobalHelper.genKey();
                    fp.addPage(
                        key: keyMapObservation,
                        content: MapsObservationPage(
                          key: keyMapObservation,
                          keyDismiss: keyMapObservation,
                        ));
                    await widget.controller.close!();
                  },
                ),
                const Divider(),
                _optionMenu(
                  icon: Icons.settings,
                  titleOption: 'CONFIGURACION',
                  onPressed: () async {
                    final keySettingsApp = GlobalHelper.genKey();
                    fp.addPage(
                        key: keySettingsApp,
                        content: ObservationPage(
                          key: keySettingsApp,
                          keyDismiss: keySettingsApp,
                        ));
                    await widget.controller.close!();
                  },
                ),
                const Divider(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: _closeSesion,
                label: const TextTitleWidget(
                  title: 'Cerrar Sesión',
                  showShadow: false,
                  color: AppTheme.white,
                ),
                icon: const Icon(
                  Icons.logout_outlined,
                  color: AppTheme.white,
                  size: 24,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _optionMenu(
      {required IconData icon,
      required String titleOption,
      required Function() onPressed}) {
    return TextButton.icon(
      style: TextButton.styleFrom(
          fixedSize: Size(context.screenWidth, 50),
          alignment: Alignment.centerLeft,
          splashFactory: InkSplash.splashFactory),
      onPressed: onPressed,
      label: TextTitleWidget(
        title: titleOption,
        color: AppTheme.white,
        showShadow: false,
      ),
      icon: Icon(
        icon,
        size: 24,
        color: AppTheme.white,
      ),
    );
  }

  _closeSesion() async {
    await widget.controller.close!();
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    final closeSesionKey = GlobalHelper.genKey();
    fp.showAlert(
      key: closeSesionKey,
      content: AlertGeneric(
        content: ConfirmContent(
          message: 'Estás a punto de cerrar la sesión actual ¿Estás Seguro?',
          confirm: () {
            fp.dismissAlert(key: closeSesionKey);
            GlobalHelper.navigateToPageRemove(context, '/login');
          },
          cancel: () {
            fp.dismissAlert(key: closeSesionKey);
          },
        ),
      ),
    );
  }
}
