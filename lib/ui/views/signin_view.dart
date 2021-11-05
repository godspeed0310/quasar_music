import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quasar_music/ui/shared/app_colors.dart';
import 'package:quasar_music/viewmodels/signin_view_model.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
      builder: (context, model, child) {
        return const AnnotatedRegion<SystemUiOverlayStyle>(
          value: systemUiOverlayStyle,
          child: Scaffold(),
        );
      },
    );
  }
}
