import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quasar_music/ui/shared/app_colors.dart';
import 'package:quasar_music/viewmodels/startup_view_model.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      viewModelBuilder: () => StartupViewModel(),
      builder: (context, model, child) {
        return const AnnotatedRegion<SystemUiOverlayStyle>(
          value: systemUiOverlayStyle,
          child: Scaffold(),
        );
      },
    );
  }
}
