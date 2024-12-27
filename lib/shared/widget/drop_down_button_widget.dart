import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';


class DropDownButtonWidget extends StatefulWidget {
  const DropDownButtonWidget(
      {super.key,
      this.items,
      this.onChanged,
      this.value,
      this.hint,
      this.validator, this.disabled = false});

  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final String? value;
  final String? hint;
  final String? Function(String?)? validator;
  final bool? disabled;

  @override
  State<DropDownButtonWidget> createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  List<double> customHeights = [40.0, 50.0, 30.0];
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Material(
        // elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 45,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      IgnorePointer(
        ignoring: widget.disabled!,
        child: DropdownButtonFormField2<String>(
          
          // onMenuStateChange: (isOpen) {
          //   if (isOpen) {
          //     FocusScope.of(context).unfocus();
          //   }
          // },
          isExpanded: true,
          //isDense : false,
          style: const TextStyle(
            fontSize:  20
          ),
          decoration: InputDecoration(
             errorStyle: const TextStyle(
              fontSize: 12,
              color: AppTheme.error,
            ),
             hintStyle: const TextStyle(
               color: AppTheme.primaryColor,
               fontSize:  30,
               fontWeight: FontWeight.normal,
             ),
            filled: true,
            fillColor: !widget.disabled! ?  AppTheme.white : AppTheme.primaryColor,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
           border: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.5, color: AppTheme.primaryColor),
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.5, color: AppTheme.primaryColor),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.5, color: AppTheme.primaryColor),
              borderRadius: BorderRadius.circular(20),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: AppTheme.error),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: AppTheme.error),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          hint: Text(
            widget.hint ?? '',
            style: const TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          items: widget.items,
          onChanged: widget.onChanged,
          value: widget.value,
          validator: widget.validator,
          buttonStyleData: const ButtonStyleData(
            height:  18,
            overlayColor: WidgetStatePropertyAll(AppTheme.white),
            elevation: 0,
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down_outlined, color: AppTheme.primaryColor),
            openMenuIcon: Icon(Icons.keyboard_arrow_up_outlined, color: AppTheme.primaryColor),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            isOverButton: true,
            elevation: 2,
            maxHeight:  220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.white,
            ),
            offset: const Offset(0, -48),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(10),
              thickness: WidgetStateProperty.all<double>(6),
              thumbVisibility: WidgetStateProperty.all<bool>(true),
            ),
          ),
        
          menuItemStyleData:  MenuItemStyleData(
            height:  40,
            padding: const EdgeInsets.only(left: 14, right: 14),
             selectedMenuItemBuilder: (context, child) {
              return Container(
                height: 40,
                decoration: const BoxDecoration(
                  //borderRadius: BorderRadius.circular(10),
                  color: AppTheme.primaryColor,
                ),
                child: child,
              );
            },
          ),
        ),
      ),
    ]);
  }
}
