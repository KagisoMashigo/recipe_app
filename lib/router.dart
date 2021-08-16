// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:

/// Important for page aware
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

final Map<String, Widget Function(BuildContext)> routes = {
  // Homepage
  // 'homePage': (context) => HomePage(),

  // auth
  // 'signInPage': (context) => SignInPage(),
  // 'signUpPage': (context) => SignUpPage(),
  // 'signUpPageSuccess': (context) => SignUpSuccessPage(),
  // 'resetPasswordEmailPage': (context) => ResetPasswordEmailPage(),
  // 'resetPasswordCodePage': (context) => ResetPasswordCodePage(),
  // 'changePasswordPage': (context) => ChangePasswordPage(),

  // Doc
  // 'policyPage': (context) => PolicyPage(),
  // 'faqPage': (context) => FaqPage(),

  // user management
  // 'userManagement': (context) => UserManagementPage(),
};
