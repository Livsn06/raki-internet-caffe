import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/screens/layout/admin-panel-layout.dart';

class RouteControls {
  RouteControls._();

  static void pushReplacement(BuildContext context, Widget screen) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static void push(BuildContext context, Widget screen) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void pushAndRemoveUntil(BuildContext context, Widget screen) async {
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }
}

class RouteScreens {
  RouteScreens._();
  static const adminPanelScreen = AdminPanelLayout();
}
