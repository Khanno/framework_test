import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RobotoCustomStyle {
  style({required BuildContext context, Color? color}) {
    return GoogleFonts.robotoMono(
        color: color ?? Theme.of(context).colorScheme.secondary,
        fontSize: 14.0,
        fontWeight: FontWeight.w600
    );
  }
}