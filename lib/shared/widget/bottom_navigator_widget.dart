import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:provider/provider.dart';

class ButtonNavigartorBarItem extends StatelessWidget {
  const ButtonNavigartorBarItem(
      {super.key, required this.fp, required this.iconSelect, required this.selecPage});

  final FunctionalProvider fp;
  final ButtonNavigatorBarItem iconSelect;
  final Function() selecPage;

  @override
  Widget build(BuildContext context) {
    final iconSelect =
        context.watch<FunctionalProvider>().buttonNavigatorBarItem;
    return Theme(
      data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: AppTheme.white),
      child: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.primaryColor,
        selectedItemColor: AppTheme.white,
        selectedLabelStyle: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w500, color: AppTheme.white),
        unselectedItemColor: AppTheme.white.withOpacity(0.8),
        // showSelectedLabels: true,
        // showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            tooltip: 'Inicio',
            icon: SvgPicture.asset(AppTheme.iconHome),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
              tooltip: 'Alerta',
              icon: SvgPicture.asset(AppTheme.iconAlert),
              label: 'Alerta'),
          BottomNavigationBarItem(
              tooltip: 'Observacion',
              icon: SvgPicture.asset(AppTheme.iconObservation),
              label: 'Observacion'),
          BottomNavigationBarItem(
              tooltip: 'Mis Aportes',
              icon: SvgPicture.asset(AppTheme.iconMyAport),
              label: 'Mis Aportes'),
          BottomNavigationBarItem(
              tooltip: 'Buscar',
              icon: SvgPicture.asset(AppTheme.iconSearch),
              label: 'Buscar'),
        ],
        currentIndex: iconSelect.index,
        onTap: (index) {
          fp.clearAllAlert();
          if (iconSelect.index == index) return;
          fp.setIconBottomNavigationBarItem(
              ButtonNavigatorBarItem.values[index]);
          selecPage();
        },
      ),
    );
  }
}
