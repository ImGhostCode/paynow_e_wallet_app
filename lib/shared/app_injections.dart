import 'package:paynow_e_wallet_app/core/utils/injections.dart';

import 'data/data_sources/app_shared_prefs.dart';

initAppInjections() {
  sl.registerFactory<AppSharedPrefs>(() => AppSharedPrefs(sl()));
}