import 'package:get_it/get_it.dart';
import 'package:paynow_e_wallet_app/core/helper/notification_service.dart';
import 'package:paynow_e_wallet_app/features/card/card_injections.dart';
import 'package:paynow_e_wallet_app/features/contact/contact_injections.dart';
import 'package:paynow_e_wallet_app/features/notification/notification_injections.dart';
import 'package:paynow_e_wallet_app/features/transaction/transaction_injections.dart';
import 'package:paynow_e_wallet_app/shared/app_injections.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paynow_e_wallet_app/features/auth/auth_injections.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  sl.registerSingleton<NotificationService>(NotificationService());
  await initSharedPrefsInjections();
  await initAppInjections();
  // await initDioInjections();
  // await initArticlesInjections();
  initAuthInjections();
  initCardInjections();
  initTransactionInjections();
  initContactInjections();
  initNotificationInjections();
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
