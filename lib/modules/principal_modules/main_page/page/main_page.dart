import 'package:flutter/material.dart';
import 'package:observa_gye_app/modules/principal_modules/home/page/home_page.dart';
import 'package:observa_gye_app/shared/widget/layout.dart';



class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return  LayoutWidget(child: HomePage(),);
  }
}