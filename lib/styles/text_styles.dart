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

class OswaldCustomStyle {
  style({required BuildContext context, Color? color}) {
    return GoogleFonts.oswald(
      color: color ?? Theme.of(context).primaryColor,
      fontSize: 12.0,
      fontWeight: FontWeight.w300,
    );
  }
}

class OxygenCustomStyle {
  style({required BuildContext context, Color? color}) {
    return GoogleFonts.oxygen(
      color: color ?? Theme.of(context).primaryColor,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );
  }
}