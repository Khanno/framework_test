import 'package:flutter/material.dart';
import 'package:framework_test/helpers/string_helper.dart';
import 'package:framework_test/model/product_model.dart';
import 'package:framework_test/styles/text_styles.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;
  final Function() onPressed;
  final Function() onTap;

  ProductCardWidget(
      {required this.product, required this.onPressed, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 2.0),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                height: 50,
                width: 50,
                child: Image.asset(
                  product.image as String,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Flexible(
              child: GestureDetector(
                onTap: onTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.name}',
                      style: OxygenCustomStyle().style(context: context),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${product.description}',
                      style: OswaldCustomStyle().style(context: context),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'R\$ ${convertCentsToReal(product.value as int)}',
                    style: OxygenCustomStyle().style(context: context),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      child: IconButton(
                        onPressed: onPressed,
                        icon: const Icon(Icons.add),
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
