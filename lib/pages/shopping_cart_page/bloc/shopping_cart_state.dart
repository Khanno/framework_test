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

class CreatingPdfState extends ShoppingCartState {
  final List<Product> shoppingCart;
  CreatingPdfState({required this.shoppingCart}) : super(shoppingCart: shoppingCart);
}

class PdfCreatedState extends ShoppingCartState {
  PdfCreatedState() : super(shoppingCart: []);
}