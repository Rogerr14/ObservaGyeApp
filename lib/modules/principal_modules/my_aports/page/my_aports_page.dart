import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/modules/principal_modules/my_aports/widget/my_alerts_page.dart';
import 'package:observa_gye_app/modules/principal_modules/my_aports/widget/my_observation_page.dart';
import 'package:observa_gye_app/shared/widget/text_widget.dart';

class MyAportsPage extends StatefulWidget {
  const MyAportsPage({super.key});

  @override
  State<MyAportsPage> createState() => _MyAportsPageState();
}

class _MyAportsPageState extends State<MyAportsPage>
    with SingleTickerProviderStateMixin {
  int _currentTab = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2,
        vsync: this,
        animationDuration: const Duration(milliseconds: 500));
  }

  void _setCurrentTab(int v) {
    if (v != _currentTab) {
      _tabController.index = v;
      _currentTab = v;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          color: AppTheme.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _TabPage(
                label: 'Mis Observaciones',
                isActive: _currentTab == 0,
                onPress: () {
                  _setCurrentTab(0);
                },
              ),
              _TabPage(
                label: 'Mis Alertas',
                isActive: _currentTab == 1,
                onPress: () {
                  _setCurrentTab(1);
                },
              ),
            ],
          ),
        ),
         SizedBox(
          height: size.height,
           child: TabBarView(
             clipBehavior: Clip.antiAlias,
             physics: const NeverScrollableScrollPhysics(),
             controller: _tabController,
             children: [
               MyObservationPage(),
               MyAlertsPage()
             ],
           ),
         ),
      ],
    );
  }
}

class _TabPage extends StatelessWidget {
  final String label;
  final bool isActive;
  final Function() onPress;
  const _TabPage(
      {required this.label, required this.isActive, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPress,
      child: Container(
        width: size.width * 0.5,
        // height: 200,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 3,
                    color: isActive ? AppTheme.primaryColor : AppTheme.white))),
        child: Center(
          child: TextSubtitleWidget(
            subtitle: label,
          ),
        ),
      ),
    );
  }
}
