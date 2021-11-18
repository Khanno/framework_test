import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework_test/helpers/string_helper.dart';
import 'package:framework_test/model/product_model.dart';
import 'package:framework_test/pages/shopping_cart_page/bloc/shopping_cart_bloc.dart';
import 'package:framework_test/pages/shopping_cart_page/bloc/shopping_cart_events.dart';
import 'package:framework_test/pages/shopping_cart_page/bloc/shopping_cart_state.dart';
import 'package:framework_test/pages/shopping_cart_page/widget/cart_product_card_widget.dart';
import 'package:framework_test/styles/button_styles.dart';
import 'package:framework_test/styles/text_styles.dart';

class ShoppingCartPage extends StatelessWidget {
  int _totalValue({required List<Product> listOfProducts}) {
    int total = 0;
    if (listOfProducts.isNotEmpty) {
      listOfProducts.forEach((product) {
        total += product.value!;
      });
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart', style: OxygenCustomStyle().style(context: context, color: Theme.of(context).colorScheme.onSurface),),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios),),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      body: BlocConsumer<ShoppingCartBloc, ShoppingCartState>(
        listener: (BuildContext context, ShoppingCartState state) {
        },
          builder: (BuildContext context, ShoppingCartState state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.shoppingCart!.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext _, int index) =>
                      CartProductCardWidget(
                    product: state.shoppingCart![index],
                    onPressed: () => context.read<ShoppingCartBloc>().add(
                        RemoveItemFromShoppingCart(
                            product: state.shoppingCart![index])),
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => context.read<ShoppingCartBloc>().add(CreateAndSavePdf()),
                        child: Text('Confirm Purchase', style: OxygenCustomStyle().style(context: context, color: Theme.of(context).colorScheme.onSurface),),
                        style: ElevatedButtonStyle().style(context: context),
                      ),
                      Text(
                        'Total: R\$ ${convertCentsToReal(_totalValue(listOfProducts: state.shoppingCart!))}',
                        style: OxygenCustomStyle().style(
                            context: context,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ElevatedButton(
                    onPressed: () => context.read<ShoppingCartBloc>().add(CreateAndSavePdf()),
                    child: Text('Confirm Purchase', style: OxygenCustomStyle().style(context: context, color: Theme.of(context).colorScheme.onSurface),),
                    style: ElevatedButtonStyle().style(context: context),
                  ),
                  Text(
                    'Total: R\$ ${convertCentsToReal(_totalValue(listOfProducts: state.shoppingCart!))}',
                    style: OxygenCustomStyle().style(
                        context: context,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
