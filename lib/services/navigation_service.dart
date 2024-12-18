import 'package:chat_me/pages/home_page.dart';
import 'package:chat_me/pages/login_page.dart';
import 'package:chat_me/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class NavigationService {
  late GlobalKey<NavigatorState> _navigatorKey;
  final Map<String, Widget Function(BuildContext)> _routes = {
    "/login": (context) => const LoginPage(),
    "/register": (context) => const RegisterPage(),
    "/home": (context) => const HomePage(),
  };
  GlobalKey<NavigatorState>? get navigatorKey {
    return _navigatorKey;
  }

  Map<String, Widget Function(BuildContext)> get routes {
    return _routes;
  }

  NavigationService() {
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  void pushedName(String routeName) {
    _navigatorKey.currentState?.pushNamed(routeName);
  }

  void pushedReplacementName(String routeName) {
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void goBack() {
    _navigatorKey.currentState?.pop();
  }
}
