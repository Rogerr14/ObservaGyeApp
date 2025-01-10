import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/principal_modules/generate_alert/page/generate_alert_page.dart';
import 'package:observa_gye_app/modules/principal_modules/generate_observation/page/generate_observation_page.dart';
import 'package:observa_gye_app/modules/principal_modules/home/page/home_page.dart';
import 'package:observa_gye_app/modules/principal_modules/my_aports/page/my_aports_page.dart';
import 'package:observa_gye_app/modules/principal_modules/search/page/search_page.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_modal.dart';
import 'package:observa_gye_app/shared/widget/bottom_navigator_widget.dart';
import 'package:observa_gye_app/shared/widget/menu_widget.dart';
import 'package:observa_gye_app/shared/widget/page_modal.dart';
import 'package:provider/provider.dart';

class LayoutWidget extends StatefulWidget {
  final String? nameInterceptor;
  Widget? child;
  final GlobalKey<State<StatefulWidget>>? keyDismiss;
  final bool requiredStack;
  LayoutWidget(
      {super.key,
      this.nameInterceptor,
      this.child,
      this.keyDismiss,
      this.requiredStack = true});

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  final ZoomDrawerController _drawerController = ZoomDrawerController();

  late FunctionalProvider fp;

  Widget contain = const HomePage();

  XFile? image;
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _selectWidgetPage();
        setState(() {});
      },
    );
    fp = Provider.of<FunctionalProvider>(context, listen: false);
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
    final size = MediaQuery.of(context).size;
    final iconSelect =
        context.watch<FunctionalProvider>().buttonNavigatorBarItem;
    return Stack(
      children: [
        Scaffold(
          // extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: AppTheme.primaryColor,
          body: ZoomDrawer(
            
            controller: _drawerController,
            menuBackgroundColor: AppTheme.primaryColor,
            angle: 0,
            openCurve: Curves.easeInOut,
            mainScreenScale: 0,
            slideWidth: size.width * 0.7,
            menuScreenWidth: size.width,
            closeCurve: Curves.elasticInOut,
            menuScreen: MenuWidget(
              controller: _drawerController,
            ),
            // mainScreen: CustomScrollView(
            //   // physics: NeverScrollableScrollPhysics(),
            //   slivers: [
            //     SliverAppBar(
            //       forceElevated: false,
            //       elevation: 0,

            //       backgroundColor: AppTheme.white,
            //       leading: IconButton(
            //           onPressed: fp.pages.isEmpty
            //               ? () {
            //                   _drawerController.open!();
            //                 }
            //               : () {
            //                   fp.dismissPage(key: widget.keyDismiss!);
            //                 },
            //           icon: fp.pages.isEmpty
            //               ? const Icon(Icons.menu)
            //               : const Icon(Icons.arrow_back_ios_new_sharp)),
            //       title: SvgPicture.asset(
            //         AppTheme.logoApp,
            //         colorFilter: const ColorFilter.mode(
            //             AppTheme.primaryColor, BlendMode.srcIn),
            //         height: size.height * 0.035,
            //       ),
            //       centerTitle: true,
            //     ),
            //     SliverFillRemaining(
            //       hasScrollBody: false,
            //       child: Column(
            //         children: [
            //           Expanded(
            //             child: Container(
            //               width: size.width,
            //               // height: size.height,
            //               decoration: const BoxDecoration(
            //                   color: AppTheme.white,
            //                   borderRadius:
            //                       BorderRadius.vertical(bottom: Radius.circular(50))),
            //               child: fp.pages.isEmpty
            //                   ? body(iconSelect: iconSelect)
            //                   : widget.child,
            //             ),
            //           ),
            //           ButtonNavigartorBarItem(
            //         iconSelect: iconSelect,
            //         fp: fp,
            //       ),
            //         ],
            //       ),

            //     ),

            //   ],
            // ),
            mainScreen: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                // primary: false,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    _drawerController.open!();
                  },
                  icon: const Icon(Icons.menu),
                ),
                backgroundColor: AppTheme.white,
                title: SvgPicture.asset(
                  AppTheme.logoApp,
                  colorFilter: const ColorFilter.mode(
                      AppTheme.primaryColor, BlendMode.srcIn),
                  height: size.height * 0.035,
                ),
                centerTitle: true,
              ),
              backgroundColor: AppTheme.primaryColor,
              body: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                      color: AppTheme.white,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(50))),
                  child: SingleChildScrollView(child: contain)),
              bottomNavigationBar: ButtonNavigartorBarItem(
                iconSelect: iconSelect,
                fp: fp,
                selecPage: _selectWidgetPage,
              ),
            ),
          ),
        ),
        if (widget.requiredStack) const PageModal(),
        if (widget.requiredStack) const AlertModal()
      ],
    );
  }

  _selectWidgetPage() async {
    switch (fp.buttonNavigatorBarItem) {
      case ButtonNavigatorBarItem.iconMenuHome:
        // fp.clearAllAlert();
        // return const HomePage();
        contain = const HomePage();
        break;
      case ButtonNavigatorBarItem.iconAlert:
        image = await picker.pickImage(source: ImageSource.camera);
        GlobalHelper.logger.w(image != null);
        if (image != null) {
          contain = GenerateAlertage(image: image!,);
        } else {
          fp.setIconBottomNavigationBarItem(
              ButtonNavigatorBarItem.iconMenuHome);
          contain = const HomePage();
        }
        setState(() {
          
        });
        break;
      case ButtonNavigatorBarItem.iconSearch:
        contain = SearchPage();
        break;
      case ButtonNavigatorBarItem.iconMyAport:
        contain = MyAportsPage();
        break;
      case ButtonNavigatorBarItem.iconObservation:
        image = await picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          contain =  GenerateObservationPage(image: image!,);
        } else {
          contain = const HomePage();
          fp.setIconBottomNavigationBarItem(
              ButtonNavigatorBarItem.iconMenuHome);
        }
        setState(() {
          
        });
        break;
      default:
        contain = HomePage();
        break;
    }
  }
}
