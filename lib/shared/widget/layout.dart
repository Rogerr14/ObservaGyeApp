import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/provider/functional_provider.dart';
import 'package:observa_gye_app/shared/widget/alert_modal.dart';
import 'package:observa_gye_app/shared/widget/page_modal.dart';
import 'package:provider/provider.dart';

class LayoutWidget extends StatefulWidget {
  final String? nameInterceptor;
  final Widget child;
  final GlobalKey<State<StatefulWidget>>? keyDismiss;
  final bool requiredStack;
  const LayoutWidget({super.key, this.nameInterceptor, required this.child, this.keyDismiss,  this.requiredStack = true});

  @override
  State<LayoutWidget> createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget> {
  final ZoomDrawerController _drawerController = ZoomDrawerController();
  int index = 0;


    @override
    void initState() {
      super.initState();
    
       BackButtonInterceptor.add(_backButton, name: widget.nameInterceptor, context: context);
    

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
    final size = MediaQuery.of(context).size;
    return ZoomDrawer(
      controller: _drawerController,
      
      menuScreen: Scaffold(
        
        backgroundColor: Colors.white,
        body: Center(
          child: InkWell(
            onTap: () {
                // z.open!();
            },
            child: Text(
              "Push Page",
              style: TextStyle(fontSize: 24.0, color: Colors.black),
            ),
          ),
        ),),
      mainScreen: Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: Stack(
          children: [
      
            Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        toolbarHeight: size.height * 0.1,
                        pinned: true,
                        elevation: 0,
                        floating: false,
                        forceElevated: false,
                        
                        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
                        backgroundColor: AppTheme.white,
                        centerTitle: true,
                        title: SvgPicture.asset(AppTheme.logoApp, colorFilter: ColorFilter.mode(AppTheme.primaryColor, BlendMode.srcIn), height: size.height *0.035,),
                      ),
                      SliverFillRemaining(
                        // hasScrollBody: false,
                        child: Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(50),),
                            
                            
                          ),
                          child: widget.child),
                      ),
                     
                    ],
                  ),
                ),
              menuBottomWidget()
               
              ],
            ),
             if (widget.requiredStack) const PageModal(),
            if (widget.requiredStack) const AlertModal()
          ],
        ),
      ),
    );
  }


  Widget menuBottomWidget () {
    return  Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                _optionMenuWidget(AppTheme.iconHome, 'Inicio', 0),
                _optionMenuWidget(AppTheme.iconAlert, 'Alertas', 1),
                _optionMenuWidget(AppTheme.iconObservation, 'Observación', 2),
                _optionMenuWidget(AppTheme.iconMyAport, 'Mis aportes', 3),
                _optionMenuWidget(AppTheme.iconSearch, 'Buscar', 4),
               ],
            );
  }


  Widget _optionMenuWidget(String icon, String title, int option){
    return  IconButton(onPressed: (){
      if(index != option){
        index = option;
      }
    }, icon: Column(children: [
      SvgPicture.asset(icon, height: 40,),
      Text(title,style: const TextStyle(color: AppTheme.white),)
    ]));
  }


}