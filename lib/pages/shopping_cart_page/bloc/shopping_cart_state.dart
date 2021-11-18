import 'package:framework_test/model/product_model.dart';

class ShoppingCartState {
  List<Product>? shoppingCart = [];
  String? message;

  ShoppingCartState({this.shoppingCart, this.message});

  ShoppingCartState copyWith({
    List<Product>? shoppingCart,
    String? message,
  }) {
    return ShoppingCartState(
      shoppingCart: shoppingCart ?? this.shoppingCart,
      message: message ?? this.message,
    );
  }
}

class PdfCreatedState extends ShoppingCartState {}