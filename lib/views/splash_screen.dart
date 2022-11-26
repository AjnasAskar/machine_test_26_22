import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:machine_test_26_22/common/route_generator.dart';
import 'package:machine_test_26_22/utils/font_palette.dart';
import 'package:machine_test_26_22/utils/theme_palette.dart';

import '../common/constants.dart';
import '../utils/helpers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemePalette.primaryColor,
        body: SizedBox.expand(
            child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              'Machine Test',
              style: FontPalette.white30Bold,
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                elevation: 0,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarBrightness: Brightness.dark,
                  statusBarIconBrightness: Brightness.light,
                  systemNavigationBarIconBrightness: Brightness.light,
                ),
              ),
            ),
          ],
        )));
  }

  @override
  void initState() {
    navToHome();
    super.initState();
  }

  void navToHome() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteGenerator.routeHomeScreen, (route) => false);
    });
  }
}
