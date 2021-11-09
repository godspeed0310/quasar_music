import 'package:flutter/material.dart';

class SoundGraph extends StatefulWidget {
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
  _SoundGraphState createState() => _SoundGraphState();
}

class _SoundGraphState extends State<SoundGraph>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _animation = IntTween(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: double.maxFinite,
          height: 100,
          child: Align(
            alignment: Alignment.center,
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(colors: [
                  widget.recordedSoundColor,
                  widget.unrecordedSoundColor
                ], stops: [
                  _controller.value,
                  _controller.value
                ]).createShader(rect);
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
                        width: widget.width,
                        height: widget.soundData[index],
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: widget.unrecordedSoundColor,
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, index) {
                  return index == widget.soundData.length - 1
                      ? const SizedBox()
                      : SizedBox(
                          width: widget.width,
                        );
                },
                itemCount: widget.soundData.length,
              ),
            ),
          ),
        );
      },
    );
  }
}
