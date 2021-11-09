import 'package:flutter/material.dart';

class SoundGraph extends StatelessWidget {
  final List<double> soundData;
  final Color unrecordedSoundColor;
  final Color recordedSoundColor;
  final double width;

  const SoundGraph(
      {Key? key,
      required this.soundData,
      required this.unrecordedSoundColor,
      required this.recordedSoundColor,
      this.width = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 100,
      child: Align(
        alignment: Alignment.center,
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(seconds: 10),
          builder: (context, double value, child) {
            return ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                    colors: [recordedSoundColor, unrecordedSoundColor],
                    stops: [value, value]).createShader(rect);
              },
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width,
                        height: soundData[index],
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: unrecordedSoundColor,
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, index) {
                  return index == soundData.length - 1
                      ? const SizedBox()
                      : SizedBox(
                          width: width,
                        );
                },
                itemCount: soundData.length,
              ),
            );
          },
        ),
      ),
    );
  }
}
