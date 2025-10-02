part of 'route_imports.dart';

class Routes {
  static TransitionType transitionType = TransitionType.fadeIn;
  static void configureRoutes(FluroRouter router) {
    router.define(
      SplashScreen.routeName,
      handler: Handler(handlerFunc: (_, __) => const SplashScreen()),
    );

    router.define(
      HomeScreen.routeName,
      transitionType: transitionType,
      handler: Handler(
        handlerFunc: (context, params) {
          final args = HomeArgs.fromJson(_queryParameters(params));
          return HomeScreen(args: args);
        },
      ),
    );
  }

  // static dynamic _arguments(BuildContext? context) {
  //   return context?.arguments;
  // }

  static Map<String, dynamic> _queryParameters(
    Map<String, List<dynamic>> parameters,
  ) {
    Map<String, String> q = {};
    parameters.forEach((key, value) {
      q.update(key, (v) => value.first, ifAbsent: () => value.first);
    });

    return q;
  }
}
