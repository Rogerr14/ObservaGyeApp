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
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 90, 0, 20),
      child: Column(
        children: [
          Row(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
          )
        ],
      ),
    );
  }

  _closeSesion()async {
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
