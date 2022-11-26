
import 'package:machine_test_26_22/services/service_config.dart';
import '../common/constants.dart';
import '../utils/http_requests.dart';

abstract class BaseProviderClass {
  final ServiceConfig serviceConfig = ServiceConfig();
  LoaderState loaderState = LoaderState.loaded;
  bool btnLoader = false;

  void pageInit() {}

  void updateBtnLoader(bool val) {
    btnLoader = val;
  }

  void updateLoaderState(LoaderState state);

  LoaderState fetchError(Exceptions exceptions) {
    Map<Exceptions, LoaderState> errorState = {
      Exceptions.socketErr: LoaderState.networkErr,
      Exceptions.noData: LoaderState.noData,
      Exceptions.err: LoaderState.error,
      Exceptions.serverErr: LoaderState.error
    };
    return errorState[exceptions] ?? LoaderState.error;
  }
}
