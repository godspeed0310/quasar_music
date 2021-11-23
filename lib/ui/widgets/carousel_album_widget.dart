import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quasar_music/models/album_model.dart';
import 'divider_widget.dart';

class CarouselAlbumWidget extends StatelessWidget {
  final String? title;
  final List<AlbumModel>? albums;

  CarouselAlbumWidget({this.title, this.albums});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        DividerWidget(
          margin: const EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: albums!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (BuildContext context, int index) {
            return CarouselAlbumItemWidget(
              album: albums![index],
            );
          },
        ),
      ],
    );
  }
}

class CarouselAlbumItemWidget extends StatelessWidget {
  final AlbumModel? album;
  CarouselAlbumItemWidget({this.album});

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
                image: CachedNetworkImageProvider(album!.artworkRawUrl!),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            album!.title!,
            overflow: TextOverflow.fade,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            album!.artistName!,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
