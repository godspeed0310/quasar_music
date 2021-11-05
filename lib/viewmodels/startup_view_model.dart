import 'package:quasar_music/constants/route_names.dart';
import 'package:quasar_music/locator.dart';
import 'package:quasar_music/services/authentication_service.dart';
import 'package:quasar_music/services/navigation_service.dart';
import 'package:quasar_music/viewmodels/base_model.dart';

class StartupViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateAndReplaceTo(homeViewRoute);
    } else {
      _navigationService.navigateAndReplaceTo(authViewRoute);
    }
  }
}
