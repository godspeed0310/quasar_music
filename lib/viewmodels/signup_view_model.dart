import 'package:quasar_music/constants/route_names.dart';
import 'package:quasar_music/locator.dart';
import 'package:quasar_music/services/authentication_service.dart';
import 'package:quasar_music/services/dialog_service.dart';
import 'package:quasar_music/services/navigation_service.dart';
import 'package:quasar_music/viewmodels/base_model.dart';

class SignupViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();

  popPage() {
    _navigationService.pop();
  }

  navigateToSignIn() {
    _navigationService.pushAndReplace(signInViewRoute);
  }

  Future signupUser({required String email, required String password}) async {
    setBusy(true);
    var result = await _authenticationService.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );

    setBusy(false);
    if (result is bool) {
      if (result) {
        _navigationService.navigateAndReplaceTo(homeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Couldn\'t Sign In',
          description: 'General Signin error, please try again later.',
        );
        setBusy(false);
      }
    } else {
      await _dialogService.showDialog(
        title: 'Couldn\'t Sign In',
        description: result,
      );
      setBusy(false);
    }
  }
}
