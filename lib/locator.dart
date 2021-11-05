import 'package:get_it/get_it.dart';
import 'package:quasar_music/services/authentication_service.dart';
import 'package:quasar_music/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthenticationService());
}
