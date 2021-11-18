import 'package:flutter/material.dart';
import 'package:framework_test/styles/text_styles.dart';

class CustomTextInputDecoration {
  style({
    required BuildContext context,
    String? label,
    String? hint,
    Color? labelColor,
    Widget? suffixIcon,
    Color? fillColor,
    Color? borderColor,
    Color? focusBorderColor,
    Color? hintColor,
  }) {
    return InputDecoration(
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: RobotoCustomStyle().style(context: context, color: hintColor),
        label: Text(label ?? '', style: RobotoCustomStyle().style(context: context, color: labelColor),),
        errorStyle: RobotoCustomStyle().style(context: context, color: Theme.of(context).colorScheme.onError),
        alignLabelWithHint: true,
        labelStyle: RobotoCustomStyle().style(context: context, color: labelColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: borderColor ?? Theme.of(context).colorScheme.secondary),
        ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: focusBorderColor ?? Theme.of(context).colorScheme.secondary),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: focusBorderColor ?? Theme.of(context).colorScheme.secondary),
      ),
      focusColor: focusBorderColor ?? Theme.of(context).colorScheme.secondary,
    );
  }
}
