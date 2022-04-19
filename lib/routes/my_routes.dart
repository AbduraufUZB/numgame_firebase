import 'package:fireprogram/screens/fire_db.dart';
import 'package:fireprogram/screens/home_page.dart';
import 'package:fireprogram/screens/login_page.dart';
import 'package:flutter/material.dart';

class MyRoutes {
  Route? onGenerateRoute(RouteSettings s) {
    var args = s.arguments;

    switch (s.name) {
      case "/":
        return MaterialPageRoute(builder: (ctx) => const LoginPage());
      case "/home":
        return MaterialPageRoute(builder: (ctx) => const HomePage());
      case "/db":
        return MaterialPageRoute(builder: (ctx) => const MyFireDb());
    }
  }
}
