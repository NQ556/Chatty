import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:chatty_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:chatty_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:chatty_app/features/friends/presentation/pages/user_detail_page.dart';
import 'package:chatty_app/features/navigation/presentation/pages/home_page.dart';
import 'package:chatty_app/features/profile/presentation/pages/edit_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String signInRoute = "/";
  static const String signUpRoute = "/signUp";
  static const String forgotRoute = "/forgot";
  static const String homeRoute = "/home";
  static const String editRoute = "/edit";
  static const String profileRoute = "/profile";
}

class UserDetailArguments {
  final User user;
  final int currentIndex;
  final bool isFriend;

  UserDetailArguments({
    required this.user,
    required this.currentIndex,
    this.isFriend = false,
  });
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
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case Routes.editRoute:
        return MaterialPageRoute(
          builder: (_) => EditPage(),
        );
      case Routes.profileRoute:
        if (routeSettings.arguments is UserDetailArguments) {
          final args = routeSettings.arguments as UserDetailArguments;

          return MaterialPageRoute(
            builder: (_) => UserDetailPage(
              user: args.user,
              currentIndex: args.currentIndex,
              isFriend: args.isFriend,
            ),
          );
        }
        return unDefinedRoute();
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
