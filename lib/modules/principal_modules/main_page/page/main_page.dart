import 'package:flutter/material.dart';
import 'package:observa_gye_app/shared/widget/layout.dart';



class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return const LayoutWidget();
  }
}