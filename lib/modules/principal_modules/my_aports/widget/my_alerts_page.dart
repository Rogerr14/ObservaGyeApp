import 'package:flutter/material.dart';
import 'package:observa_gye_app/modules/principal_modules/my_aports/widget/list_widget.dart';

class MyAlertsPage extends StatefulWidget {
  const MyAlertsPage({super.key});

  @override
  State<MyAlertsPage> createState() => _MyAlertsPageState();
}

class _MyAlertsPageState extends State<MyAlertsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) => ListWidget(isGeneral: false,),
    );
  }
}
