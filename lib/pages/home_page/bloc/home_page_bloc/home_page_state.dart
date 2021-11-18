import 'package:framework_test/model/product_model.dart';

class HomePageState {
  List<Product>? listOfProducts;
  String? searchTerm;
  String? message;

  HomePageState({this.listOfProducts, this.searchTerm, this.message});

  HomePageState copyWith({
    List<Product>? listOfProducts,
    String? searchTerm,
    String? message,
  }) {
    return HomePageState(
      listOfProducts: listOfProducts ?? this.listOfProducts,
      searchTerm: searchTerm ?? this.searchTerm,
      message: message ?? this.message
    );
  }
}

class HomePageLoadingState extends HomePageState {}

class ErrorHomePageState extends HomePageState {
  final List<Product> listOfProducts;
  final String message;

  ErrorHomePageState({required this.message, required this.listOfProducts,}) : super(message: message, listOfProducts: listOfProducts);
}