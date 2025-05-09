import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:observa_gye_app/env/theme/apptheme.dart';
import 'package:observa_gye_app/shared/helpers/global_helper.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.hintText,
    this.maxHeigth = double.infinity,
    this.maxWidth = double.infinity,
    this.controller,
    this.validator,
    this.inputFormatters,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.fillColor = Colors.white,
    this.fontWeightHintText = FontWeight.w400,
    this.maxLines = 1,
    this.showShading = true,
    this.borderWith = 1,
    this.focusNode,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.enabled,
    this.initialValue,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onSaved, 
    this.fontSizeHint = 17,
  });

  final double maxHeigth;
  final double maxWidth;
  final double fontSizeHint;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final Color? fillColor;
  final FontWeight? fontWeightHintText;
  final int? maxLines;
  final bool? showShading;
  final double? borderWith;
  final FocusNode? focusNode;
  final bool? enabled;
  final bool? readOnly;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String? initialValue;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final void Function(String?)? onSaved;
  //final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    //final theme = AppTheme();
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      onTap: onTap,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      initialValue: initialValue,
      readOnly: readOnly!,
      enabled: enabled,
      focusNode: focusNode,
      maxLines: maxLines,
      obscuringCharacter: '*',
      obscureText: obscureText,
      style:  TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w700, fontSize: fontSizeHint),
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      validator: validator,
      controller: controller,
      onTapOutside: (pointerDownEvent) {
        GlobalHelper.dismissKeyboard(context);
        //FocusScope.of(context).unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
      },
      textAlign: textAlign,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        
          errorStyle: const TextStyle(
            color: AppTheme.error,
          ),
          filled: true,
          fillColor: fillColor,
          hintText: hintText,
          
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          alignLabelWithHint: true,
          isCollapsed: false,
          isDense: true,
          hintStyle: TextStyle(
              fontWeight: fontWeightHintText, color: AppTheme.primaryColor),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeigth),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: borderWith!, color: AppTheme.primaryColor),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: borderWith!, color: AppTheme.primaryColor),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: borderWith!, color: AppTheme.primaryColor),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: borderWith!, color: AppTheme.primaryColor),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: borderWith!, color: AppTheme.error),
            borderRadius: BorderRadius.circular(20),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: borderWith!, color: AppTheme.hinText),
            borderRadius: BorderRadius.circular(20),
          ), ),
    );
  }
}
