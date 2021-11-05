import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
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
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: systemUiOverlayStyle,
          child: Scaffold(
            body: Center(
              child: SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child:
                          SvgPicture.asset('lib/assets/images/quasar_logo.svg'),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Quasar Music',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
