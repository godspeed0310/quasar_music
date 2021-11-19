import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MusicWidget extends StatelessWidget {
  final String imgUri;
  final String title;
  final List<String> artists;

  const MusicWidget(
      {Key? key,
      required this.imgUri,
      required this.artists,
      required this.title})
      : super(key: key);

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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(imgUri),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            overflow: TextOverflow.fade,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            artists.length != 1
                ? '${artists[0]} and ${artists[1]}'
                : artists[0],
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
