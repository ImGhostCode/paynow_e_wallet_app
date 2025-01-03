import 'package:get_it/get_it.dart';
import 'package:paynow_e_wallet_app/shared/app_injections.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paynow_e_wallet_app/features/auth/auth_injections.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initSharedPrefsInjections();
  await initAppInjections();
  // await initDioInjections();
  // await initArticlesInjections();
  initAuthInjections();
}

initSharedPrefsInjections() async {
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
}

// Future<void> initDioInjections() async {
//   initRootLogger();
//   DioNetwork.initDio();
// }
