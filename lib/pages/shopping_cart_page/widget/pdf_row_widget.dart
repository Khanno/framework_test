import 'package:flutter/material.dart';

class PdfRowWidget extends StatelessWidget {

  final String name;
  final String value;

  PdfRowWidget({required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Text('R\$ $value'),
      ],
    );
  }
}
