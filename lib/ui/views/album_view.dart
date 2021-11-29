import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quasar_music/models/album_model.dart';
import 'package:quasar_music/services/song_service.dart';
import 'package:quasar_music/ui/shared/app_colors.dart';
import 'package:quasar_music/ui/views/song_view.dart';

class AlbumView extends StatefulWidget {
  final String? albumId;
  final String? albumName;

  const AlbumView({Key? key, this.albumId, this.albumName}) : super(key: key);

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  late Future<AlbumModel> _album;
  SongService _songService = SongService.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _album = _songService.fetchAlbumById(widget.albumId!);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: scaffoldBackgroundColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: FutureBuilder<AlbumModel>(
          future: _album,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            } else if (snapshot.hasData) {
              final album = snapshot.data;
              final List<Widget> list = [
                AlbumHeader(
                  album: album!,
                ),
              ];
              int songIndex = 1;

              list.add(
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
              );

              list.add(
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Tracklist',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );

              list.add(
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
              );

              album.songs?.forEach(
                (song) {
                  list.add(
                    ListTile(
                      minVerticalPadding: 15,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SongView(
                              song: song,
                              coverArt: album.artworkUrl(512),
                            ),
                          ),
                        );
                      },
                      leading: Text(
                        songIndex.toString(),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      title: Text(
                        song.title!,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      trailing: Icon(EvaIcons.heart),
                    ),
                  );
                  songIndex++;
                },
              );

              return ListView(
                physics: const BouncingScrollPhysics(),
                children: list,
              );
            } else {
              return const Center(
                child: Text(
                  'No data found',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class AlbumHeader extends StatelessWidget {
  final AlbumModel album;

  const AlbumHeader({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(top: 50),
          sliver: SliverToBoxAdapter(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    album.artworkUrl(512),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 30),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  album.title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 10),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'By ${album.artistName!}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
