import 'dart:developer';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final router = FluroRouter();
  static void pop({dynamic result}) {
    AppRouter.navigatorKey.currentState!.pop(result);
  }

  static void popUntil(String name) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(name));
  }

  static Future push(
    String routeName, {
    Map<String, dynamic>? queryParameters,
    dynamic arguments,
  }) async {
    final url =
        Uri(path: routeName, queryParameters: queryParameters).toString();
    log("Push => $url");
    return router.navigateTo(
      navigatorKey.currentState!.context,
      url,
      routeSettings: RouteSettings(arguments: arguments),
    );
  }

  static Future pushReplacement(
    String routeName, {
    Map<String, dynamic>? queryParameters,
    dynamic arguments,
  }) async {
    final url =
        Uri(path: routeName, queryParameters: queryParameters).toString();
    log("Push Replacement => $url");
    return router.navigateTo(
      navigatorKey.currentState!.context,
      url,
      replace: true,
      routeSettings: RouteSettings(arguments: arguments),
    );
  }

  static Future pushAndRemove(
    String routeName, {
    Map<String, dynamic>? queryParameters,
    dynamic arguments,
  }) async {
    final url =
        Uri(path: routeName, queryParameters: queryParameters).toString();
    log("Push And Remove => $url");
    return router.navigateTo(
      navigatorKey.currentState!.context,
      url,
      clearStack: true,
      routeSettings: RouteSettings(arguments: arguments),
    );
  }

  static String currentRoute() {
    return Uri.base.path;
  }
}
