import 'package:flutter/material.dart';
import 'package:quasar_music/constants/route_names.dart';

import 'views/auth_view.dart';
import 'views/signin_view.dart';
import 'views/signup_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case signupViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewtoShow: SignupView(),
      );
    case signInViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewtoShow: SignInView(),
      );
    case authViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewtoShow: AuthView(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String? routeName, Widget? viewtoShow}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewtoShow!,
  );
}
