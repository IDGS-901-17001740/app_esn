import 'package:flutter/material.dart';
import 'package:muebleria_valadez/screens/screen.dart';

class AppRoutes {
  static String initialRouter = '/';

  static onGenerateRoute(settings) {
    return MaterialPageRoute(builder: (context) => const ErrorScreen());
  }

  static final routes = {'/': (BuildContext context) => LoginScreen()};
}
