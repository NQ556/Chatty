import 'package:chatty_app/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:chatty_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:chatty_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String signInRoute = "/";
  static const String signUpRoute = "/signUp";
  static const String forgotRoute = "/forgot";
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
      case Routes.forgotRoute:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordPage(),
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
