import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_26_22/models/route_arguments.dart';
import 'package:machine_test_26_22/views/cart_screen.dart';
import 'package:machine_test_26_22/views/home_screen.dart';
import 'package:machine_test_26_22/views/product_detail_screen.dart';

import '../views/splash_screen.dart';

class RouteGenerator {
  static RouteGenerator? _instance;
  static RouteGenerator get instance {
    _instance ??= RouteGenerator();
    return _instance!;
  }

  static const String routeInitial = "/";
  static const String routeHomeScreen = "/homeScreen";
  static const String routeProductDetailScreen = "/productDetailScreen";
  static const String routeCartScreen = "/cartScreen";
  static const String routeError = "/error";

  Route generateRoute(RouteSettings settings, {var routeBuilders}) {
    var args = settings.arguments;
    switch (settings.name) {
      case routeInitial:
        return _buildRoute(routeInitial, const SplashScreen());
      case routeHomeScreen:
        return _buildRoute(routeInitial, const HomeScreen());
      case routeProductDetailScreen:
        return _buildRoute(
            routeInitial,
            ProductDetailScreen(
              routArguments:
                  args != null ? args as RoutArguments : RoutArguments(),
            ));
      case routeCartScreen:
        return _buildRoute(routeInitial, const CartScreen());

      default:
        return _buildRoute(routeError, const ErrorView());
    }
  }

  Route _buildRoute(String route, Widget widget,
      {bool enableFullScreen = false}) {
    return CupertinoPageRoute(
        fullscreenDialog: enableFullScreen,
        settings: RouteSettings(name: route),
        builder: (_) => widget);
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Error View")),
        body: const Center(child: Text('Page not found')));
  }
}
