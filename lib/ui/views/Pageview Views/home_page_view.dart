import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quasar_music/ui/shared/app_colors.dart';
import 'package:quasar_music/viewmodels/home_model_view.dart';
import 'package:stacked/stacked.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeModelView>.reactive(
      onModelReady: (model) => model.initAcr(),
      viewModelBuilder: () => HomeModelView(),
      builder: (context, model, child) {
        return CustomPaint(
          painter: BackgroundPainter(),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 100,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Hum\nyour song!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          EvaIcons.optionsOutline,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(
                    height: 70,
                  ),
                  InkWell(
                    onTap: () async {
                      model.isRecognising
                          ? await model.stopRecognizing()
                          : await model.startRecognizing();
                    },
                    borderRadius: BorderRadius.circular(1000),
                    child: Ink(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: primaryGradient,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.5),
                            offset: const Offset(8, 8),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          model.isRecognising
                              ? EvaIcons.stopCircle
                              : EvaIcons.micOutline,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Ink(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      const Offset(0, 0),
      100,
      Paint()..color = lightgrey.withOpacity(0.4),
    );
    canvas.drawCircle(
      const Offset(0, 0),
      190,
      Paint()
        ..strokeWidth = 1
        ..color = lightgrey.withOpacity(0.4)
        ..style = PaintingStyle.stroke,
    );
    canvas.drawCircle(
      const Offset(0, 0),
      240,
      Paint()
        ..strokeWidth = 1
        ..color = lightgrey.withOpacity(0.4)
        ..style = PaintingStyle.stroke,
    );
    canvas.drawCircle(
      const Offset(0, 0),
      290,
      Paint()
        ..strokeWidth = 1
        ..color = lightgrey.withOpacity(0.4)
        ..style = PaintingStyle.stroke,
    );
    canvas.drawCircle(
      const Offset(0, 0),
      340,
      Paint()
        ..strokeWidth = 1
        ..color = lightgrey.withOpacity(0.4)
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
