import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/widget/text_form_field_widget.dart';

class DateTimePickerWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onTap;

  const DateTimePickerWidget({
    super.key,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // final responsive = Responsive(context);
    return GestureDetector(
      onTap: onTap,
      child: TextFormFieldWidget(
        controller: controller,
        hintText: 'Seleccione la fecha',
        enabled: false,
         validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La fecha es requerida.';
              }
              return null;
            },
        suffixIcon: const Icon(Icons.calendar_month_sharp, size:24,color: AppTheme.primaryColor,),
      ),
    );
  }
}
