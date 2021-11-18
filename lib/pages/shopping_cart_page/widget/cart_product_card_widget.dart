import 'package:flutter/material.dart';
import 'package:framework_test/model/product_model.dart';
import 'package:framework_test/styles/text_styles.dart';
import 'package:framework_test/helpers/string_helper.dart';

class CartProductCardWidget extends StatelessWidget {
  final Product product;
  final Function() onPressed;

  CartProductCardWidget({required this.product, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(width: 1.0)),
      margin: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                        width: 50, height: 50, child: Image.asset(product.image!, fit: BoxFit.fill,))),
                SizedBox(width: 15.0,),
                Expanded(
                  child: Text(
                    '${product.name}',
                    style: OswaldCustomStyle().style(context: context, fontSize: 14.0, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'R\$ ${convertCentsToReal(product.value as int)}',
                style: OxygenCustomStyle().style(context: context),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                width: 15.0,
              ),
              CircleAvatar(
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .onBackground,
                  child:
                  IconButton(onPressed: onPressed, icon: Icon(Icons.remove))),
            ],
          ),
        ],
      ),
    );
  }
}
