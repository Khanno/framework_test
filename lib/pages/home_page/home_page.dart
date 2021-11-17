import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework_test/pages/home_page/bloc/home_page_bloc.dart';
import 'package:framework_test/pages/home_page/bloc/home_page_state.dart';
import 'package:framework_test/pages/home_page/widgets/product_card_widget.dart';
import 'package:framework_test/widgets/text_inputs/custom_text_input.dart';

class HomePage extends StatelessWidget {

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        toolbarHeight: 75.0,
        title: CustomTextInput(
          suffixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary,),
          controller: searchController,
          hint: 'Search for an item here',
          keyboardType: TextInputType.name,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<HomePageBloc, HomePageState>(
          listener: (BuildContext context, HomePageState state) {},
          builder: (BuildContext context, HomePageState state) {
            switch (state.runtimeType) {
              case HomePageLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case HomePageState:
                return Padding(
                  padding: const EdgeInsets.fromLTRB(45.0, 0, 45.0, 0),
                  child: ListView.builder(
                      itemCount: state.listOfProducts!.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ProductCardWidget(
                            product: state.listOfProducts![index],
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
