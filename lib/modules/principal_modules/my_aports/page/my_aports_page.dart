import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';


class MyAportsPage extends StatefulWidget {
  const MyAportsPage({super.key});

  @override
  State<MyAportsPage> createState() => _MyAportsPageState();
}

class _MyAportsPageState extends State<MyAportsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: size.height *0.05,
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primaryColor)
                ),
                child: Center(child: Text('Mis Observaciones')),
              ),
              Container(
                child: Text('Mis Alertas'),
              ),
            ],
          )
          // PageView.builder(itemBuilder:(context, index) {
            
          // },)
        ],
      ),
    );
  }
}