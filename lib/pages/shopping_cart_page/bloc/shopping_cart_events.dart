import 'package:framework_test/model/product_model.dart';

class ShoppingCartEvent {}

class AddItemToShoppingCart extends ShoppingCartEvent {
  final Product product;

  AddItemToShoppingCart({required this.product});
}

class RemoveItemFromShoppingCart extends ShoppingCartEvent {
  final Product product;

  RemoveItemFromShoppingCart({required this.product});
}

class ResetShoppingCart extends ShoppingCartEvent {}

class CreateAndSavePdf extends ShoppingCartEvent {}