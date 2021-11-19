import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlaylistPageView extends StatelessWidget {
  const PlaylistPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 250,
            width: 250,
            child: SvgPicture.asset(
              'lib/assets/images/no_music_illustration.svg',
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'No playlists found on your account.\nCreate a new playlist to see it here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
