import 'package:quasar_music/constants/route_names.dart';
import 'package:quasar_music/locator.dart';
import 'package:quasar_music/services/navigation_service.dart';
import 'package:quasar_music/viewmodels/base_model.dart';

class AuthViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  signupUser() {
    _navigationService.navigateTo(signupViewRoute);
  }

  signInUser() {
    _navigationService.navigateTo(signInViewRoute);
  }
}
