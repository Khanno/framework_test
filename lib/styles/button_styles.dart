import 'package:flutter/material.dart';
import 'package:framework_test/styles/text_styles.dart';

class ElevatedButtonStyle {
  style({required BuildContext context}) {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Theme
            .of(context)
            .colorScheme
            .secondaryVariant),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 35.0)),
        textStyle: MaterialStateProperty.all(
            RobotoCustomStyle().style(context: context, color: Colors.white),
        ),
    );
  }
}