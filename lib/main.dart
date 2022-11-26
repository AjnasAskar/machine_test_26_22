import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:machine_test_26_22/utils/theme_palette.dart';
import 'package:provider/provider.dart';

import 'common/multi_provider_list.dart';
import 'common/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MultiProviderList.providerList,
      child: MaterialApp(
        title: 'Machine Test',
        debugShowCheckedModeBanner: false,
        theme: ThemePalette.themeData,
        onGenerateRoute: RouteGenerator.instance.generateRoute,
      ),
    );
  }
}
