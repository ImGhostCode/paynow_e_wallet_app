import 'package:get_it/get_it.dart';
import 'package:paynow_e_wallet_app/core/network/dio_network.dart';
import 'package:paynow_e_wallet_app/shared/app_injections.dart';
import 'package:paynow_e_wallet_app/core/utils/log/app_logger.dart';
import 'package:paynow_e_wallet_app/features/articles/articles_injections.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initSharedPrefsInjections();
  await initAppInjections();
  await initDioInjections();
  await initArticlesInjections();
}

initSharedPrefsInjections() async {
  sl.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
  await sl.isReady<SharedPreferences>();
}

Future<void> initDioInjections() async {
  initRootLogger();
  DioNetwork.initDio();
}
