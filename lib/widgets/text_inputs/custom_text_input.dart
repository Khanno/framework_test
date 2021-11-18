import 'package:flutter/material.dart';
import 'package:framework_test/styles/text_input_styles.dart';
import 'package:framework_test/styles/text_styles.dart';

class CustomTextInput extends StatelessWidget {
  final String? label;
  final bool isRequired;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String? hint;
  final Color? labelColor;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Function(String)? onChanged;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? hintColor;
  final Color? textInputColor;
  final Color? cursorColor;
  final Widget? prefixIcon;

  CustomTextInput({
    this.label,
    this.isRequired = false,
    required this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.hint,
    this.labelColor,
    this.suffixIcon,
    this.fillColor,
    this.onChanged,
    this.borderColor,
    this.focusBorderColor,
    this.hintColor,
    this.textInputColor,
    this.cursorColor,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      decoration: CustomTextInputDecoration().style(
        context: context,
        label: label,
        hint: hint,
        labelColor: labelColor,
        suffixIcon: suffixIcon,
        fillColor: fillColor,
        borderColor: borderColor,
        focusBorderColor: focusBorderColor,
        hintColor: hintColor,
        prefixIcon: prefixIcon,
      ),
      cursorColor: cursorColor,
      keyboardType: keyboardType ?? TextInputType.name,
      textAlign: TextAlign.center,
      obscureText: isPassword,
      style: RobotoCustomStyle().style(context: context, color: textInputColor),
      validator: (value) {
        if (isRequired) {
          if (value == null || value.isEmpty) {
            return 'This is a required field';
          }
        }

        if (value != null && value.length < 3 && !isPassword) {
          return 'This field requires at least 3 characters';
        }

        if (isPassword) {
          if (value != null && value.length < 6) {
            return 'A password must have at least 6 numbers';
          }
        }
        return null;
      },
    );
  }
}
