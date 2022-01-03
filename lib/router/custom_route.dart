import 'package:flutter/material.dart';
import 'package:companies_alkhudra/pages/language_page.dart';
import 'package:companies_alkhudra/pages/login_page.dart';
import 'package:companies_alkhudra/pages/sign_up_page.dart';
import 'package:companies_alkhudra/pages/welcome_page.dart';
import 'package:companies_alkhudra/router/route_constants.dart';


class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LogInPage());
      case signupRoute:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case languageRoute:
        return MaterialPageRoute(builder: (_) => LanguagePage());
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => WelcomePage());
      default:
        return MaterialPageRoute(builder: (_) => LanguagePage());
    }
  }
}