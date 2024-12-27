enum AppRouteEnum {
  introPage,
  welcomePage,
  loginPage,
  signupPage,
  articlesPage,
  articleDetailsPage,
  weViewPage,
  photoViewPage,
  sendMoneyPage,
  requestMoneyPage,
  requestsPage,
  myInfoPage,
  resetPasswordPage,
  settingsPage,
  myCardsPage
}

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.introPage:
        return "/intro_page";

      case AppRouteEnum.welcomePage:
        return "/welcome_page";

      case AppRouteEnum.loginPage:
        return "/login_page";

      case AppRouteEnum.signupPage:
        return "/signup_page";

      case AppRouteEnum.sendMoneyPage:
        return "/send_money_page";

      case AppRouteEnum.requestMoneyPage:
        return "/request_money_page";

      case AppRouteEnum.requestsPage:
        return "/requests_page";

      case AppRouteEnum.articlesPage:
        return "/articles_page";

      case AppRouteEnum.articleDetailsPage:
        return "/article_details_page";

      case AppRouteEnum.weViewPage:
        return "/web_view_page";

      case AppRouteEnum.photoViewPage:
        return "/photo_view_page";

      case AppRouteEnum.myInfoPage:
        return "/my_info_page";

      case AppRouteEnum.resetPasswordPage:
        return "/reset_password_page";

      case AppRouteEnum.settingsPage:
        return "/settings_page";

      case AppRouteEnum.myCardsPage:
        return "/my_cards_page";
      default:
        return "/articles_page";
    }
  }
}
