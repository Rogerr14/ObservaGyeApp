import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      Image.asset(
                        AppTheme.iconUser,
                        height: 50,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextTitleWidget(
                            title: 'Usuario Usuario',
                            color: AppTheme.white,
                            showShadow: false,
                          ),
                          TextSubtitleWidget(
                            subtitle: 'Ver perfil',
                            color: AppTheme.white,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                _optionMenu(Icons.abc, 'Hola'),
                Divider(),
                _optionMenu(Icons.abc, 'Hola'),
                Divider(),
                _optionMenu(Icons.abc, 'Hola'),
                Divider(),
                _optionMenu(Icons.abc, 'Hola'),
                Divider(),
                _optionMenu(Icons.abc, 'Hola'),
                Divider(),
                _optionMenu(Icons.abc, 'Hola'),
                Divider(),
                _optionMenu(Icons.abc, 'Hola'),
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

  _optionMenu(IconData icon, String titleOption) {
    
    return TextButton.icon(
      style: TextButton.styleFrom(
        fixedSize: Size(context.screenWidth, 50),
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(),
        splashFactory: InkSplash.splashFactory
      ),
        onPressed: () {},
        label: TextTitleWidget(
          title: titleOption,
          color: AppTheme.white,
          showShadow: false,
        ),
        icon: Icon(icon, size: 24, color: AppTheme.white,),
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
          confirm: () {},
          cancel: () {
            fp.dismissAlert(key: closeSesionKey);
          },
        ),
      ),
    );
  }
}
