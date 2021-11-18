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
  final ScrollController scrollController = ScrollController();

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
        title: Text(
          'Shopping Cart',
          style: OxygenCustomStyle().style(
              context: context, color: Theme.of(context).colorScheme.onSurface),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      body: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
          builder: (BuildContext context, ShoppingCartState state) {
            switch (state.runtimeType) {
              case CreatingPdfState:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case PdfCreatedState:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('Receipt created'),
                    ),
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Row(
                          children: [
                            Text('Return to home page'),
                            SizedBox(width: 15.0,),
                            Icon(Icons.keyboard_return),
                          ],
                        ))
                  ],
                );
              case ShoppingCartPage:
                return Scrollbar(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: state.shoppingCart!.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext _, int index) =>
                                CartProductCardWidget(
                              product: state.shoppingCart![index],
                              onPressed: () => context
                                  .read<ShoppingCartBloc>()
                                  .add(RemoveItemFromShoppingCart(
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
                                  onPressed: () => context
                                      .read<ShoppingCartBloc>()
                                      .add(CreateAndSavePdf()),
                                  child: Text(
                                    'Confirm Purchase',
                                    style: OxygenCustomStyle().style(
                                        context: context,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                  ),
                                  style: ElevatedButtonStyle()
                                      .style(context: context),
                                ),
                                Text(
                                  'Total: R\$ ${convertCentsToReal(_totalValue(listOfProducts: state.shoppingCart!))}',
                                  style: OxygenCustomStyle().style(
                                      context: context,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              default:
                return Text('Something went wrong.');
            }
          }),
    );
  }
}
