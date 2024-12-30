import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/pages/login_page.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/pages/signup_page.dart';
import 'package:paynow_e_wallet_app/features/intro/presentation/pages/intro_page.dart';
import 'package:paynow_e_wallet_app/features/intro/presentation/pages/welcome_page.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/pages/add_card_page.dart';
import 'package:paynow_e_wallet_app/features/card/presentation/pages/my_cards_page.dart';
import 'package:paynow_e_wallet_app/features/profile/presentation/pages/my_info_page.dart';
import 'package:paynow_e_wallet_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:paynow_e_wallet_app/features/profile/presentation/pages/settings_page.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/pages/request_money_page.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/pages/requests_page.dart';
import 'package:paynow_e_wallet_app/features/transaction/presentation/pages/send_money_page.dart';
import 'package:paynow_e_wallet_app/shared/presentation/pages/photo_view_page.dart';
import 'package:paynow_e_wallet_app/shared/presentation/pages/web_view_page.dart';
import 'package:paynow_e_wallet_app/features/articles/domain/models/article_model.dart';
import 'package:paynow_e_wallet_app/features/articles/presentation/pages/article_details_page.dart';
import 'package:paynow_e_wallet_app/features/articles/presentation/pages/articles_page.dart';

class AppRouter {
  static String currentRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "/";
    switch (settings.name) {
      // ==== Auth pages ==== //
      case '/intro_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const IntroPage(),
        );

      case '/welcome_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const WelcomePage(),
        );

      case '/login_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const LoginPage(),
        );

      case '/signup_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const SignupPage(),
        );

      // ==== Home pages ==== //
      case '/send_money_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => SendMoneyPage(),
        );

      case '/request_money_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => RequestMoneyPage(),
        );

      case '/requests_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => RequestsPage(),
        );

      // ==== Profile pages ==== //
      case '/my_info_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => MyInfoPage(),
        );

      case '/reset_password_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => ResetPasswordPage(),
        );

      case '/settings_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const SettingsPage(),
        );

      case '/my_cards_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const MyCardsPage(),
        );

      case '/add_card_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const AddCardPage(),
        );

      // Ny Times Articles page
      case '/articles_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const ArticlesPage(),
        );

      // Ny Times Article Details page
      case '/article_details_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) {
            assert(
                settings.arguments != null, "nyTimesArticleModel is required");
            return ArticleDetailsPage(
              model: settings.arguments as ArticleModel,
            );
          },
        );

      // Web view page
      case '/web_view_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => WebViewPage(
            link: settings.arguments as String,
          ),
        );

      // Photo view page
      case '/photo_view_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) {
            Map<String, dynamic>? args =
                settings.arguments as Map<String, dynamic>?;
            assert(args != null, "You should pass 'path' and 'fromNet'");
            return PhotoViewPage(
              path: args!['path'],
              fromNet: args['fromNet'],
            );
          },
        );

      default:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
