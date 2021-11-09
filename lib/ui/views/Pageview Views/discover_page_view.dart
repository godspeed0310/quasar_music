import 'package:flutter/material.dart';

class DiscoverPageView extends StatelessWidget {
  const DiscoverPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text(
          'Discover',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
