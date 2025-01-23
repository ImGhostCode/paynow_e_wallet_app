import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynow_e_wallet_app/core/router/app_route_enum.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/bloc/card_bloc.dart';
import 'package:paynow_e_wallet_app/shared/data/data_sources/app_shared_prefs.dart';
import 'package:paynow_e_wallet_app/core/router/router.dart';
import 'package:paynow_e_wallet_app/core/styles/app_theme.dart';
import 'package:paynow_e_wallet_app/core/translations/l10n.dart';
import 'package:paynow_e_wallet_app/core/helper/helper.dart';
import 'package:paynow_e_wallet_app/core/utils/injections.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

import '/shared/domain/entities/language_enum.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Inject all dependencies
  await initInjections();
  // await sl<SharedPreferences>().clear();
  // await FirebaseAuth.instance.signOut();
  runApp(DevicePreview(
    builder: (context) {
      return const App();
    },
    enabled: kDebugMode,
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

final GlobalKey<ScaffoldMessengerState> snackBarKey =
    GlobalKey<ScaffoldMessengerState>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();

  static void setLocale(BuildContext context, LanguageEnum newLocale) {
    _AppState state = context.findAncestorStateOfType()!;
    state.setState(() {
      state.locale = Locale(newLocale.name);
    });
    sl<AppSharedPrefs>().setLang(newLocale);
  }
}

class _AppState extends State<App> with WidgetsBindingObserver {
  Locale locale = const Locale("en");

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    if (mounted) {
      LanguageEnum newLocale = Helper.getLang();
      setState(() {
        locale = Locale(newLocale.local);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppNotifier(),
      child: Consumer<AppNotifier>(
        builder: (context, value, child) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            useInheritedMediaQuery: true,
            builder: (context, child) {
              ScreenUtil.configure(
                data: MediaQuery.of(context),
              );
              return MultiBlocProvider(
                providers: [
                  BlocProvider<AuthBloc>(
                    create: (BuildContext context) => AuthBloc(
                      loginUsecase: sl(),
                      signUpUsecase: sl(),
                      getUserUsecase: sl(),
                      updateUserUsecase: sl(),
                    ),
                  ),
                  BlocProvider<CardBloc>(
                    create: (BuildContext context) => CardBloc(
                      getCardUsecase: sl(),
                      addCardUsecase: sl(),
                      updateCardUsecase: sl(),
                      deleteCardUsecase: sl(),
                    ),
                  ),
                ],
                child: MaterialApp(
                  title: 'PayNow E-Wallet',
                  scaffoldMessengerKey: snackBarKey,
                  initialRoute: AppRouteEnum.splashPage.name,
                  onGenerateRoute: AppRouter.generateRoute,
                  theme: Helper.isDarkTheme() ? darkTheme : lightTheme,
                  debugShowCheckedModeBanner: false,
                  locale: locale,
                  builder: kDebugMode ? DevicePreview.appBuilder : null,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  navigatorKey: navigatorKey,
                  supportedLocales: const [
                    Locale("ar"),
                    Locale("en"),
                  ],
                  // home: const MyApp(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// App notifier for Lang, Theme, ...
class AppNotifier extends ChangeNotifier {
  late bool darkTheme;

  AppNotifier() {
    _initialise();
  }

  Future _initialise() async {
    darkTheme = Helper.isDarkTheme();

    notifyListeners();
  }

  void updateThemeTitle(bool newDarkTheme) {
    darkTheme = newDarkTheme;
    if (Helper.isDarkTheme()) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notifyListeners();
  }
}
