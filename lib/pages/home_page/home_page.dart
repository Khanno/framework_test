import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework_test/pages/home_page/bloc/home_page_bloc/home_page_bloc.dart';
import 'package:framework_test/pages/home_page/bloc/home_page_bloc/home_page_events.dart';
import 'package:framework_test/pages/home_page/bloc/home_page_bloc/home_page_state.dart';
import 'package:framework_test/pages/home_page/widgets/information_card_widget.dart';
import 'package:framework_test/pages/shopping_cart_page/bloc/shopping_cart_bloc.dart';
import 'package:framework_test/pages/shopping_cart_page/bloc/shopping_cart_events.dart';
import 'package:framework_test/pages/shopping_cart_page/bloc/shopping_cart_state.dart';
import 'package:framework_test/pages/home_page/widgets/product_card_widget.dart';
import 'package:framework_test/styles/text_styles.dart';
import 'package:framework_test/widgets/text_inputs/custom_text_input.dart';

class HomePage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      appBar: AppBar(
        toolbarHeight: 75.0,
        title: CustomTextInput(
          cursorColor: Theme.of(context).colorScheme.onBackground,
          borderColor: Theme.of(context).colorScheme.onBackground,
          focusBorderColor: Colors.white,
          hintColor: Theme.of(context).colorScheme.onBackground,
          textInputColor: Theme.of(context).colorScheme.onBackground,
          suffixIcon: GestureDetector(
            onTap: () {
              if (searchController.text.isNotEmpty) {
                context.read<HomePageBloc>().add(SearchProductsHomePageEvent(searchWord: searchController.text));
              } else {
                context.read<HomePageBloc>().add(LoadingHomePageEvent());
              }
            },
            child: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          controller: searchController,
          label: 'Search for an item here',
          labelColor: Theme.of(context).colorScheme.onBackground,
          keyboardType: TextInputType.name,
          onChanged: (String value) {
            if (value.isNotEmpty) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
                context.read<HomePageBloc>().add(SearchProductsHomePageEvent(searchWord: searchController.text));
              });
            } else {
              context.read<HomePageBloc>().add(LoadingHomePageEvent());
            }
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
                builder: (BuildContext context, ShoppingCartState cartState) {
                  return Stack(
                    children: [
                      Center(
                        child: IconButton(
                          onPressed: () =>
                          Navigator.pushNamed(context, '/shopping-cart'),
                          icon: Icon(Icons.shopping_cart),
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    Visibility(
                      visible: cartState.shoppingCart!.isNotEmpty,
                      child: Positioned(
                          top: 8,
                          right: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.red,
                            ),
                            width: 20,
                            height: 20,
                            child: Text(
                              '${cartState.shoppingCart!.length}',
                              textAlign: TextAlign.center,
                              style: RobotoCustomStyle().style(context: context, color: Colors.white,
                              ),
                            ),
                          ),
                      ),
                    ),
                ],
              );
            }),
          )
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<HomePageBloc, HomePageState>(
          listener: (BuildContext context, HomePageState state) {},
          builder: (BuildContext context, HomePageState state) {
            switch (state.runtimeType) {
              case HomePageLoadingState:
                return const Center(child: CircularProgressIndicator());
              case HomePageState:
                return Scrollbar(
                  controller: scrollController,
                  child: ListView.builder(
                      controller: scrollController,
                      physics: BouncingScrollPhysics(),
                      itemCount: state.listOfProducts!.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ProductCardWidget(
                            onTap: () => showDialog(context: context, builder: (_) => InformationCardWidget(product: state.listOfProducts![index])),
                            product: state.listOfProducts![index],
                            onPressed: () => context.read<ShoppingCartBloc>().add(AddItemToShoppingCart(product: state.listOfProducts![index])),
                          )),
                );
              default:
                return Text('Something went wrong');
            }
          },
        ),
      ),
    );
  }
}
