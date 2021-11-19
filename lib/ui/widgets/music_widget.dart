import 'package:flutter/material.dart';

class MusicWidget extends StatelessWidget {
  const MusicWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 155,
            width: MediaQuery.of(context).size.width * 0.4,
            color: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'The Feels',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'TWICE',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
