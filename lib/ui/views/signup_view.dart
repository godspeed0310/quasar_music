import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quasar_music/ui/shared/app_colors.dart';
import 'package:quasar_music/viewmodels/signup_view_model.dart';
import 'package:stacked/stacked.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      builder: (context, model, child) {
        return const AnnotatedRegion<SystemUiOverlayStyle>(
          value: systemUiOverlayStyle,
          child: Scaffold(),
        );
      },
    );
  }
}
