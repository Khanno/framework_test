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
          style: OxygenCustomStyle().style(context: context, color: Theme.of(context).colorScheme.onSurface),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
            builder: (BuildContext context, ShoppingCartState state) {
              return IconButton(
                  onPressed: () {
                    switch(state.runtimeType) {
                      case PdfCreatedState:
                        context.read<ShoppingCartBloc>().add(ResetShoppingCart());
                        return Navigator.pop(context);
                      default:
                        return Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.arrow_back_ios),
              );
            }
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      body: SafeArea(
        child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
            builder: (BuildContext context, ShoppingCartState state) {
              switch (state.runtimeType) {
                case CreatingPdfState:
                  return Center(child: CircularProgressIndicator());
                case PdfCreatedState:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Receipt created successfully!',
                          style: OxygenCustomStyle().style(context: context),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      ElevatedButton(
                        onPressed: () {
                          context.read<ShoppingCartBloc>().add(ResetShoppingCart());
                          Navigator.pop(context);
                        },
                        style: ElevatedButtonStyle().style(context: context),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Return to home page',
                                style: OxygenCustomStyle().style(context: context, color: Colors.white),
                              ),
                              SizedBox(width: 15.0),
                              Icon(
                               Icons.keyboard_return,
                               color: Colors.white,
                              ),
                            ],
                        ),
                      ),
                ],
              );
            case ShoppingCartState:
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Scrollbar(
                  controller: scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: state.shoppingCart!.isNotEmpty ?
                        ListView.builder(
                          controller: scrollController,
                          itemCount: state.shoppingCart!.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext _, int index) =>
                            CartProductCardWidget(
                              product: state.shoppingCart![index],
                              onPressed: () => context.read<ShoppingCartBloc>().add(RemoveItemFromShoppingCart(product: state.shoppingCart![index])),
                          ),
                        ) : Center(child: Text('Your shopping cart is empty :(', style: OxygenCustomStyle().style(context: context),),)
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(state.shoppingCart != null && state.shoppingCart!.isNotEmpty) {
                                        context.read<ShoppingCartBloc>().add(CreateAndSavePdf());
                                      } else {
                                        final snackBar = SnackBar(
                                            content: Text(
                                              'Your shopping cart is empty.',
                                              style: OxygenCustomStyle().style(
                                                  context: context,
                                                  color: Theme.of(context).colorScheme.onSurface
                                              ),
                                            ),
                                          backgroundColor: Theme.of(context).colorScheme.primary,
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                    },
                                    child: Text(
                                      'Confirm',
                                      style: OxygenCustomStyle().style(context: context, color: Theme.of(context).colorScheme.onSurface),
                                    ),
                                    style: ElevatedButtonStyle().style(context: context),
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                                Expanded(
                                  child: Text(
                                    'Total: R\$ ${convertCentsToReal(_totalValue(listOfProducts: state.shoppingCart!))}',
                                    textAlign: TextAlign.right,
                                    style: OxygenCustomStyle().style(context: context, color: Theme.of(context).colorScheme.primary),
                                  ),
                                ),
                              ],
                            ),
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
          },
        ),
      ),
    );
  }
}
