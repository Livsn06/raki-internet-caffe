import 'package:flutter/material.dart';

import '../screens/layout/product-layout-screen.dart';

class RouteControls {
  RouteControls._();

  static void pushReplacement(BuildContext context, Widget screen) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}

class RouteScreens {
  RouteScreens._();
  static const productScreen = ProductLayoutScreen();
}
