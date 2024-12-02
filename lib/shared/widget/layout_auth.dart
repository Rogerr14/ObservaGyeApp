import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_modal.dart';
import 'package:provider/provider.dart';


class LayoutAuth extends StatefulWidget {

  final Widget child;
  final String? routeName;
  final bool? viewButtonLeading;
  final bool requiredStack;
  final GlobalKey<State<StatefulWidget>>? keyDismiss;
  final String? nameInterceptor;

  const LayoutAuth({super.key, required this.child, this.routeName, this.viewButtonLeading, required this.requiredStack, this.keyDismiss, this.nameInterceptor});

  @override
  State<LayoutAuth> createState() => _LayoutAuthState();
}

class _LayoutAuthState extends State<LayoutAuth> {
    bool snap = false;
  bool floating = false;
  ScrollController _scrollController = ScrollController();



    @override
    void initState() {
      super.initState();
       _scrollController = ScrollController();
    }

    
    @override
    void dispose() {
      _scrollController;
      super.dispose();
    }

   Future<bool> _backButton(bool button, RouteInfo info) async {
    if (widget.nameInterceptor == null) {
      return true;
    } else {
      final fp = Provider.of<FunctionalProvider>(context, listen: false);
      if (mounted) {
        if (button) return false;
        if (fp.alertLoading.isNotEmpty ||
            (fp.alerts.last.key != widget.keyDismiss)) {
          debugPrint('aqui estoy porque tiene una alerta levantada');
          return false;
        }
        debugPrint('la alerta se cerro retrocede');
        fp.dismissAlert(key: widget.keyDismiss!);
      }
      return true;
    }
    //return true;

    //debugPrint(widget.nameInterceptor);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppTheme.primaryColor,
      body: Stack(
        children: [
          CustomScrollView(
            // controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            slivers: [
                SliverAppBar(
                  title:  Hero(
                    tag: 'logo',
                    child: SvgPicture.asset(AppTheme.logoApp, height: size.height * 0.05)
                  ),
                // toolbarHeight: size.height * 0.10,
                // automaticallyImplyLeading: true,
                snap: true,
                stretch: true,
                // stretchTriggerOffset: 200,
                floating: true,
                elevation: 0,
                centerTitle: true,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(35))),
                backgroundColor: AppTheme.primaryColor,
                // flexibleSpace: FlexibleSpaceBar(
                //     background: Padding(padding: EdgeInsets.symmetric(horizontal: size.width * 0.6, vertical: size.height * 0.9),
                //   child: Hero(
                //     tag: 'logo',
                //     child: SvgPicture.asset(AppTheme.logoApp, height: size.height * 0.30)
                //   ),
                // )
                // ),
                // expandedHeight: 100,
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                // fillOverscroll: true,
                child: Align(
                  alignment: Alignment.center,
                  
                  child: widget.child,
                )
                  )
            ],
          ),
          const AlertModal()
        ],
      ),
    );
  }
}