import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../providers/app_data_provider.dart';
import '../providers/connectivity_provider.dart';

class MultiProviderList {
  static List<SingleChildWidget> providerList = [
    ChangeNotifierProvider(create: (_) => AppDataProvider()),
    ChangeNotifierProvider(create: (context) {
      ConnectivityProvider changeNotifier = ConnectivityProvider();
      changeNotifier.initialLoad();
      return changeNotifier;
    }),
  ];
}
