import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';



class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child:  TextFormFieldWidget(
            hintText: 'Buscar...',
            suffixIcon: Icon(Icons.search, size: 30, color: AppTheme.primaryColor,),
          ),
        )
      ],
    );
  }
}