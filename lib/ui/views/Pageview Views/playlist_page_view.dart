import 'package:flutter/material.dart';

class PlaylistPageView extends StatelessWidget {
  const PlaylistPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text(
          'My Playlist',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
