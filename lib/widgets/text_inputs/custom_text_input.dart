import 'package:flutter/material.dart';
import 'package:framework_test/styles/text_input_styles.dart';
import 'package:framework_test/styles/text_styles.dart';

class CustomTextInput extends StatelessWidget {

  final String? label;
  final bool isRequired;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextEditingController controller;

  CustomTextInput({this.label, this.isRequired = false, required this.controller, this.isPassword = false, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: CustomTextInputDecoration().style(context: context, label: label),
      keyboardType: keyboardType ?? TextInputType.name,
      textAlign: TextAlign.center,
      obscureText: isPassword,
      style: RobotoCustomStyle().style(context: context),
      validator: (value) {
        if(isRequired) {
          if(value == null || value.isEmpty) {
            return 'This is a required field';
          }
        }

        if(value!= null && value.length < 3) {
          return 'This field requires at least 3 characters';
        }

        if(isPassword) {
          if (value != null && value.length < 6) {
            return 'A password must have at least 6 numbers';
          }
        }
        return null;
      },
    );
  }
}
