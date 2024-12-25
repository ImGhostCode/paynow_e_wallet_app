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

      default:
        return "/articles_page";
    }
  }
}
