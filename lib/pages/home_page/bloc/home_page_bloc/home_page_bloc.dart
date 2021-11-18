import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework_test/model/product_model.dart';
import 'package:framework_test/pages/home_page/bloc/home_page_bloc/home_page_events.dart';
import 'package:framework_test/pages/home_page/bloc/home_page_bloc/home_page_state.dart';
import 'package:framework_test/data/data.dart' as fruits;

class HomePageBloc extends Bloc<HomePageEvents, HomePageState> {
  HomePageBloc() : super(HomePageLoadingState()){
    on<LoadingHomePageEvent>((event, emit) => _loadHomePageToState(event, emit));
    on<SearchProductsHomePageEvent>((event, emit) => _searchProductsToState(event, emit));
    add(LoadingHomePageEvent());
  }

  void _loadHomePageToState(LoadingHomePageEvent event, Emitter<HomePageState> emit) {
    emit(HomePageLoadingState());
    List<Product> listOfProducts = [];
    fruits.data.forEach((fruit) {
      Product product = Product.fromMap(product: fruit);
      listOfProducts.add(product);
    });
    emit(HomePageState(listOfProducts: listOfProducts));
  }

  void _searchProductsToState(SearchProductsHomePageEvent event, Emitter<HomePageState> emit) {
    List<Product> searchedList = [];
    fruits.data.forEach((element) {
      if(element['name']!.toLowerCase().contains(event.searchWord)) {
        final Product product = Product.fromMap(product: element);
        searchedList.add(product);
      }
    });
    emit(HomePageState(searchTerm: state.searchTerm, listOfProducts: searchedList));
  }
}