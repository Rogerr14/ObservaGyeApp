import 'package:flutter/material.dart';
import 'package:observa_gye_app/modules/principal_modules/my_aports/widget/list_widget.dart';


class MyObservationPage extends StatefulWidget {
  const MyObservationPage({super.key});

  @override
  State<MyObservationPage> createState() => _MyObservationPageState();
}

class _MyObservationPageState extends State<MyObservationPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) => ListWidget(isGeneral: false,),
      ),
    );
  }
}