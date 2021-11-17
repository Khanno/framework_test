import 'package:framework_test/model/product_model.dart';

class HomePageState {
  List<Product> listOfProducts;
  String? searchTerm;
  String? message;

  HomePageState({required this.listOfProducts, this.searchTerm, this.message});
}

class ErrorHomePageState extends HomePageState {
  final List<Product> listOfProducts;
  final String message;

  ErrorHomePageState({required this.message, required this.listOfProducts}) : super(message: message, listOfProducts: listOfProducts);
}