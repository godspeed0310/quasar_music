import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quasar_music/models/song_model.dart';
import 'package:quasar_music/ui/views/song_view.dart';

class CarouselSongWidget extends StatelessWidget {
  final String? title;
  final List<SongModel>? songs;
  final String? cta;
  final dynamic onCtaTapped;

  CarouselSongWidget({this.title, this.songs, this.cta, this.onCtaTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 40,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'The best new releases',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: ListView.builder(
                itemCount: songs!.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return CarouselSongItemWidget(
                    songModel: songs![index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselSongItemWidget extends StatelessWidget {
  final SongModel? songModel;

  const CarouselSongItemWidget({this.songModel, Key? key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SongView(
              song: songModel!,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 155,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    songModel!.artworkUrl(128),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              songModel!.title!,
              overflow: TextOverflow.fade,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              songModel!.artistName!,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
