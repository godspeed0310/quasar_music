import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:quasar_music/models/album_model.dart';
import 'package:quasar_music/models/song_model.dart';
import 'package:quasar_music/services/song_service.dart';
import 'divider_widget.dart';

class AlbumWidget extends StatefulWidget {
  final String? albumId;
  final String? albumName;
  AlbumWidget({this.albumId, this.albumName});
  @override
  State<StatefulWidget> createState() {
    return AlbumWidgetState();
  }
}

class AlbumWidgetState extends State<AlbumWidget> {
  Future<AlbumModel>? _album;
  SongService deezerService = SongService.instance;

  @override
  void initState() {
    super.initState();
    _album = deezerService.fetchAlbumById(widget.albumId!);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.albumName!),
        ),
        child: FutureBuilder<AlbumModel>(
            future: _album,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final album = snapshot.data;
                final List<Widget> list = [AlbumHeaderWidget(album: album)];
                int songIndex = 1;

                album!.songs!.forEach((s) {
                  list.add(AlbumSongItemWidget(
                    index: songIndex,
                    song: s,
                  ));
                  songIndex++;
                });

                return ListView(
                  children: list,
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

class AlbumHeaderWidget extends StatelessWidget {
  final AlbumModel? album;

  AlbumHeaderWidget({this.album});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(top: 24.0, left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.network(
                          album!.artworkUrl(512),
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        )),
                  )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    album!.title!,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 4.0)),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        album!.artistName!,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .apply(color: Colors.red),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  const Padding(padding: const EdgeInsets.only(top: 4.0)),
                  Text(
                    "${album!.title![0]}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .apply(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ))
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
          ),
          Container(),
          DividerWidget(
            margin: const EdgeInsets.only(left: 0),
          )
        ],
      ),
    );
  }
}

class AlbumSongItemWidget extends StatelessWidget {
  final int? index;
  final SongModel? song;

  AlbumSongItemWidget({this.index, this.song});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "$index",
                    style: Theme.of(context).textTheme.caption,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(right: 8),
                  ),
                  Expanded(
                      child: Text(
                    song!.title!,
                    style: Theme.of(context).textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )),
                  const Padding(
                    padding: const EdgeInsets.only(right: 8),
                  ),
                  const Icon(
                    Icons.play_arrow,
                    color: Colors.red,
                  )
                ],
              ),
              DividerWidget(
                margin: const EdgeInsets.only(top: 8.0, left: 16.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
