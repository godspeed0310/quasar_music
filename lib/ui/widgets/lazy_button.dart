import 'package:flutter/material.dart';

class LazyButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  final bool busy;

  const LazyButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.busy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: busy
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Colors.white,
                  ),
                )
              : Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
        ),
      ),
    );
  }
}
