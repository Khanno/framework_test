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
  }) {
    return InputDecoration(
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        hintText: hint,
        label: Text(label ?? '', style: RobotoCustomStyle().style(context: context),),
        errorStyle: RobotoCustomStyle().style(context: context, color: Theme.of(context).colorScheme.onError),
        alignLabelWithHint: true,
        labelStyle: RobotoCustomStyle().style(context: context, color: labelColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
      ),
      focusColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
