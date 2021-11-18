import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework_test/pages/home_page/bloc/home_page_bloc/home_page_bloc.dart';
import 'package:framework_test/pages/shopping_cart_page/bloc/shopping_cart_bloc.dart';
import 'package:framework_test/pages/home_page/home_page.dart';
import 'package:framework_test/pages/login_page/login_page.dart';
import 'package:framework_test/pages/shopping_cart_page/shopping_cart_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomePageBloc>(create: (_) => HomePageBloc(),),
        BlocProvider<ShoppingCartBloc>(create: (_) => ShoppingCartBloc(),)
      ],
      child: MaterialApp(
        theme: ThemeData().copyWith(
            primaryColor: Color(0xFF184E77),
            focusColor: Color(0xFF99D98C),
            backgroundColor: Color(0xFFB5E48C),
            colorScheme: ColorScheme(
                primary: Color(0xFF184E77),
                primaryVariant: Color(0xFF1E6091),
                secondary: Color(0xFF1A759F),
                secondaryVariant: Color(0xFF168AAD),
                surface: Color(0xFF34A0A4),
                background: Color(0xFFB5E48C),
                error: Colors.red,
                onPrimary: Color(0xFF52B69A),
                onSecondary: Color(0xFF76C893),
                onSurface: Color(0xFF99D98C),
                onBackground: Color(0xFFD9ED92),
                onError: Colors.redAccent,
                brightness: Brightness.light)),
        routes: {
          '/': (_) => LoginPage(),
          '/homescreen': (_) => HomePage(),
          '/shopping-cart': (_) => ShoppingCartPage(),
        },
      ),
    ),
  );
}
