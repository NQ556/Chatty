import 'package:chatty_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:chatty_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String signInRoute = "/";
  static const String signUpRoute = "/signUp";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.signInRoute:
        return MaterialPageRoute(
          builder: (_) => SignInPage(),
        );
      case Routes.signUpRoute:
        return MaterialPageRoute(
          builder: (_) => SignUpPage(),
        );
      default:
        return unDefinedRoute();
    }
  }
}

Route<dynamic> unDefinedRoute() {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      appBar: AppBar(
        title: Text("No Route Found"),
      ),
      body: Center(
        child: Text("No Route Found"),
      ),
    ),
  );
}
