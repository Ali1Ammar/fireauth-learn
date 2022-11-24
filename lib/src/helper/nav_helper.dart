import 'package:flutter/material.dart';

class NavigatorHelper {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static push(Widget child) {
    navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) {
      return child;
    }));
  }
}
