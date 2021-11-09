import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quasar_music/locator.dart';
import 'package:quasar_music/ui/router.dart';

import 'manager/dialog_manager.dart';
import 'services/dialog_service.dart';
import 'services/navigation_service.dart';
import 'ui/shared/app_colors.dart';
import 'ui/views/startup_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quasar Music',
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigationKey,
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(
            child: child!,
          ),
        ),
      ),
      theme: ThemeData(
        primaryColorLight: primaryColorLight,
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme:
            Theme.of(context).textTheme.apply(fontFamily: 'SFProDisplay'),
      ),
      home: const StartupView(),
      onGenerateRoute: generateRoute,
    );
  }
}
