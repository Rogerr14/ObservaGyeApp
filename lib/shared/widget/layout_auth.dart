import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_modal.dart';
import 'package:observa_gye_app/shared/widget/page_modal.dart';
import 'package:provider/provider.dart';


class LayoutAuth extends StatefulWidget {

  final String? nameInterceptor;
  final Widget child;
  final GlobalKey<State<StatefulWidget>>? keyDismiss;
  final bool requiredStack;

  const LayoutAuth({
    super.key, 
    required this.child,
    this.requiredStack = true, 
    this.keyDismiss, 
    this.nameInterceptor});

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
    
       BackButtonInterceptor.add(_backButton, name: widget.nameInterceptor, context: context);
    

       _scrollController = ScrollController();
    }

    
    @override
    void dispose() {
      _scrollController;
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
             
              SliverFillRemaining(
                hasScrollBody: false,
                // fillOverscroll: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: SvgPicture.asset(AppTheme.logoApp, height: size.height * 0.05)
                    ),
                    SizedBox(height: size.height * 0.05,),
                    widget.child,
                  ],
                )
                  )
            ],
          ),
          if (widget.requiredStack) const PageModal(),
          if (widget.requiredStack) const AlertModal()
        ],
      ),
    );
  }
}