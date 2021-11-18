import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework_test/model/product_model.dart';
import 'package:framework_test/pages/shopping_cart_page/bloc/shopping_cart_events.dart';
import 'package:framework_test/pages/shopping_cart_page/bloc/shopping_cart_state.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  ShoppingCartBloc() : super(ShoppingCartState(shoppingCart: [])) {
    on<AddItemToShoppingCart>((event, emit) => _addItemToState(event, emit));
    on<RemoveItemFromShoppingCart>((event, emit) => _removeItemFromState(event, emit));
  }

  void _addItemToState(AddItemToShoppingCart event, Emitter<ShoppingCartState> emit) {
    List<Product> shoppingCart = state.shoppingCart!;
    shoppingCart.add(event.product);
    emit(state.copyWith(shoppingCart: shoppingCart));
  }

  void _removeItemFromState(RemoveItemFromShoppingCart event, Emitter<ShoppingCartState> emit) {
    List<Product> shoppingCart = state.shoppingCart!;
    int productIndex = shoppingCart.indexOf(event.product);
    shoppingCart.removeAt(productIndex);
    emit(ShoppingCartState(shoppingCart: shoppingCart));
  }
}