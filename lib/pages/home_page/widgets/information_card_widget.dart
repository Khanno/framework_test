import 'package:flutter/material.dart';
import 'package:framework_test/helpers/string_helper.dart';
import 'package:framework_test/model/product_model.dart';
import 'package:framework_test/styles/text_styles.dart';

class InformationCardWidget extends StatelessWidget {
  final Product product;

  InformationCardWidget({required this.product});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15.0,),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                  width: 250.0,
                  height: 250.0,
                  child: Image.asset(
                    product.image as String,
                    fit: BoxFit.fill,
              )),
            ),
            SizedBox(height: 15.0,),
            Text(product.name as String, style: OxygenCustomStyle().style(context: context),),
            SizedBox(height: 15.0,),
            Text(product.description as String, style: RobotoCustomStyle().style(context: context), textAlign: TextAlign.justify,),
            SizedBox(height: 30.0,),
            Text('Price:   R\$ ${convertCentsToReal(product.value as int)}', style: OxygenCustomStyle().style(context: context),),
          ],
        ),
      ),
    );
  }
}
