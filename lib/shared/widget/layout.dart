import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_modal.dart';
import 'package:observa_gye_app/shared/widget/menu_widget.dart';
import 'package:observa_gye_app/shared/widget/page_modal.dart';
import 'package:provider/provider.dart';

class LayoutWidget extends StatefulWidget {
  final String? nameInterceptor;
  final Widget child;
  final GlobalKey<State<StatefulWidget>>? keyDismiss;
  final bool requiredStack;
  const LayoutWidget(
      {super.key,
      this.nameInterceptor,
      required this.child,
      this.keyDismiss,
      this.requiredStack = true});

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  final ZoomDrawerController _drawerController = ZoomDrawerController();

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(_backButton,
        name: widget.nameInterceptor, context: context);
  }

  @override
  void dispose() {
    BackButtonInterceptor.removeByName(widget.nameInterceptor.toString());
    super.dispose();
  }

  Future<bool> _backButton(bool button, RouteInfo info) async {
    if (widget.nameInterceptor == null) {
      return true;
    } else {
      if (mounted) {
        if (button) return false;
        final fp = Provider.of<FunctionalProvider>(context, listen: false);
        if (fp.alerts.isNotEmpty) {
          return false;
        }
        fp.dismissPage(key: widget.keyDismiss!);
      }
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconSelect = context.watch<FunctionalProvider>().iconAppBarItem;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: ZoomDrawer(
        controller: _drawerController,
        menuBackgroundColor: AppTheme.primaryColor,
        angle: 0,
        openCurve: Curves.easeInOut,
        mainScreenScale: 0,
        slideWidth: size.width * 0.7,
        closeCurve: Curves.elasticInOut,
        menuScreen: MenuWidget(),
        mainScreen: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        // toolbarHeight: size.height * 0.1,
                        pinned: true,
                        elevation: 0,
                        floating: false,
                        forceElevated: false,

                        leading: IconButton(
                            onPressed: () {
                              _drawerController.open!();
                            },
                            icon: Icon(Icons.menu)),
                        backgroundColor: AppTheme.white,
                        centerTitle: true,
                        title: SvgPicture.asset(
                          AppTheme.logoApp,
                          colorFilter: ColorFilter.mode(
                              AppTheme.primaryColor, BlendMode.srcIn),
                          height: size.height * 0.035,
                        ),
                      ),
                      SliverFillRemaining(
                        // hasScrollBody: false,
                        child: Container(
                            width: size.width,
                            decoration: const BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(50),
                              ),
                            ),
                            child: widget.child),
                      ),
                    ],
                  ),
                ),
                menuBottomWidget(iconSelect, context)
              ],
            ),
            if (widget.requiredStack) const PageModal(),
            if (widget.requiredStack) const AlertModal()
          ],
        ),
      ),
    );
  }

  Widget menuBottomWidget(IconItems iconSelect, BuildContext context) {
    final fp = Provider.of<FunctionalProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _optionMenuWidget(
              icon: AppTheme.iconHome,
              title: 'Inicio',
              onPressed: () {
                GlobalHelper.logger.w(fp.iconAppBarItem);
                if (fp.iconAppBarItem != IconItems.iconMenuHome) {
                  fp.iconAppBarItem = IconItems.iconMenuHome;
                  fp.clearAllAlert();
                }
              }),
          _optionMenuWidget(
              icon: AppTheme.iconAlert,
              title: 'Alertas',
              onPressed: () {
                fp.iconAppBarItem = IconItems.iconAlert;
              }),
          _optionMenuWidget(
              icon: AppTheme.iconObservation,
              title: 'Observación',
              onPressed: () {}),
          _optionMenuWidget(
              icon: AppTheme.iconMyAport,
              title: 'Mis aportes',
              onPressed: () {}),
          _optionMenuWidget(
              icon: AppTheme.iconSearch, title: 'Buscar', onPressed: () {}),
        ],
      ),
    );
  }

  Widget _optionMenuWidget(
      {required String icon,
      required String title,
      required Function() onPressed}) {
    return IconButton(
        onPressed: onPressed,
        icon: Column(children: [
          SvgPicture.asset(
            icon,
            height: 40,
          ),
          Text(
            title,
            style: const TextStyle(color: AppTheme.white),
          )
        ]));
  }
}
