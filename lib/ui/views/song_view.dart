import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:quasar_music/locator.dart';
import 'package:quasar_music/models/song_model.dart';
import 'package:quasar_music/services/authentication_service.dart';
import 'package:quasar_music/services/firestore_service.dart';
import 'package:quasar_music/ui/shared/app_colors.dart';

class SongView extends StatefulWidget {
  final SongModel song;
  final String? coverArt;

  const SongView({Key? key, required this.song, this.coverArt = ''})
      : super(key: key);

  @override
  State<SongView> createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  late bool isLiked;
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final AuthenticationService _authService = locator<AuthenticationService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = false;
  }

  @override
  Widget build(BuildContext context) {
    var musicPlayer = AudioPlayer();

    return Scaffold(
      body: SizedBox.expand(
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
                      widget.song.artworkUrl(512) == ''
                          ? widget.coverArt!
                          : widget.song.artworkUrl(512),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.song.title!,
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
                widget.song.artistName!,
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
                      musicPlayer.play(widget.song.previewUrl!);
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
                      toggleLike();
                      showToast(
                        !isLiked
                            ? 'Removed from favourites'
                            : 'Added to favourites',
                        animation: StyledToastAnimation.slideFromBottomFade,
                        curve: Curves.bounceIn,
                        context: context,
                      );
                    },
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_outline,
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
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    !isLiked ? removeFromFavourites() : addToFavourites();
  }

  addToFavourites() async {
    await _firestoreService.addToFav(widget.song, _authService.currentUser.uid);
  }

  removeFromFavourites() async {
    await _firestoreService.removeFromFav(
        widget.song, _authService.currentUser.uid);
  }
}
