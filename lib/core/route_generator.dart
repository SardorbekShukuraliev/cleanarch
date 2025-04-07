import 'package:flutter/material.dart';
import 'package:cleanarch/core/route_names.dart';
import 'package:cleanarch/features/product/presentation/pages/all_products_page.dart';
import '../features/auth/presentation/pages/sign_in_page.dart';

class AppRoute {
  BuildContext context;

  AppRoute({required this.context});

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.signInPage:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case RouteNames.allProductsPage:
        return MaterialPageRoute(builder: (_) => const AllProductsPage());
      default:
        return _errorRoute();
    }
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      ),
    );
  }
}
