import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:quasar_music/ui/shared/app_colors.dart';

Widget ResultView(model, context) {
  var musicPlayer = AudioPlayer();

  return SizedBox.expand(
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
          ),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  model.currentSong.artworkUrl(1000),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.currentSong.title!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            model.currentSong.artistName!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  musicPlayer.play(model.currentSong.previewUrl!);
                },
                child: const Icon(
                  Icons.play_arrow,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  musicPlayer.pause();
                },
                child: const Icon(
                  Icons.pause,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  musicPlayer.stop();
                },
                child: const Icon(
                  Icons.stop,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  model.toggleLike();
                  showToast(
                    !model.isLiked
                        ? 'Removed from favourites'
                        : 'Added to favourites',
                    animation: StyledToastAnimation.slideFromBottomFade,
                    curve: Curves.bounceIn,
                    context: context,
                  );
                },
                icon: Icon(
                  model.isLiked ? Icons.favorite : Icons.favorite_outline,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          const Spacer(),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor),
              fixedSize: MaterialStateProperty.all(
                const Size(
                  200,
                  50,
                ),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Add to playlist',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                const Size(
                  200,
                  50,
                ),
              ),
              side: MaterialStateProperty.all(
                const BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
            onPressed: () {
              model.updateSuccessState(false);
            },
            child: const Text(
              'Recognize Another Song',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    ),
  );
}
