import 'package:framework_test/model/product_model.dart';

class ShoppingCartState {
  List<Product>? shoppingCart = [];

  ShoppingCartState({this.shoppingCart});

  ShoppingCartState copyWith({
    List<Product>? shoppingCart,
  }) {
    return ShoppingCartState(
      shoppingCart: shoppingCart ?? this.shoppingCart,
    );
  }
}

class LoadingShoppingCart extends ShoppingCartState {}