import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';

class GpsUbicationWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onTap;

  const GpsUbicationWidget(
      {super.key, required this.controller, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormFieldWidget(
        controller: controller,
        hintText: 'Ubicación',
        enabled: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "La ubicación es requerida";
          }
          return null;
        },
        suffixIcon: const Icon(Icons.gps_fixed_outlined, size: 24, color: AppTheme.primaryColor,),
      ),
    );
  }
}
