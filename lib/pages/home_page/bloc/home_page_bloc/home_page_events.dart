class HomePageEvents {}

class LoadingHomePageEvent extends HomePageEvents {}

class SearchProductsHomePageEvent extends HomePageEvents {
  final String searchWord;
  SearchProductsHomePageEvent({required this.searchWord});
}