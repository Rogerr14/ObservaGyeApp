import 'package:animate_do/animate_do.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_modal.dart';
import 'package:observa_gye_app/shared/widget/page_modal.dart';
import 'package:provider/provider.dart';

class LayoutPageGeneric extends StatefulWidget {
  final String? nameInterceptor;
  final Widget child;
  final Widget? iconSuffix;
  final GlobalKey<State<StatefulWidget>>? keyDismiss;
  final bool requiredStack;
  const LayoutPageGeneric(
      {super.key,
      this.nameInterceptor,
      required this.child,
      this.keyDismiss,
      this.requiredStack = true, this.iconSuffix});

  @override
  State<LayoutPageGeneric> createState() => _LayoutPageGenericState();
}

class _LayoutPageGenericState extends State<LayoutPageGeneric> {
  late FunctionalProvider fp;

  XFile? image;
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();

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

    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              // primary: false,
              automaticallyImplyLeading: false,
              actions: [
                widget.iconSuffix ?? const SizedBox()
              ],
              leading: IconButton(
                  onPressed: () {
                    fp.dismissPage(key: widget.keyDismiss!);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_sharp)),
              backgroundColor: AppTheme.white,
              title: SvgPicture.asset(
                AppTheme.logoApp,
                colorFilter: const ColorFilter.mode(
                    AppTheme.primaryColor, BlendMode.srcIn),
                height: size.height * 0.035,
              ),
              centerTitle: true,
            ),
            backgroundColor: AppTheme.white,
            body: widget.child),
        if (widget.requiredStack) const PageModal(),
        if (widget.requiredStack) const AlertModal()
      ],
    );
  }
}
