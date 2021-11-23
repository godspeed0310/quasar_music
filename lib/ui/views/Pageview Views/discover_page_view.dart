import 'package:flutter/material.dart';
import 'package:quasar_music/services/song_service.dart';
import 'package:quasar_music/ui/shared/app_colors.dart';
import 'package:quasar_music/ui/widgets/carousel_album_widget.dart';
import 'package:quasar_music/ui/widgets/carousel_song_widget.dart';
import 'package:quasar_music/viewmodels/discover_model_view.dart';

class DiscoverPageView extends StatefulWidget {
  const DiscoverPageView({Key? key}) : super(key: key);

  @override
  State<DiscoverPageView> createState() => _DiscoverPageViewState();
}

class _DiscoverPageViewState extends State<DiscoverPageView> {
  late Future<DiscoverData> _discoverData;
  final SongService songService = SongService.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _discoverData = DiscoverModelView().fetchDiscoverList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<DiscoverData>(
        future: _discoverData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<Widget> list = [];

            final albumChart = snapshot.data!.chart!.albumChart;
            final songChart = snapshot.data!.chart!.songChart;

            if (songChart != null) {
              list.add(
                const SizedBox(
                  height: 20,
                ),
              );
              list.add(
                CarouselSongWidget(
                  title: 'Top Songs',
                  songs: songChart.songs,
                ),
              );
              list.add(
                const SizedBox(height: 10),
              );
              list.add(
                CarouselAlbumWidget(
                  title: 'New albums & singles',
                  albums: albumChart!.albums!,
                ),
              );
            }
            return ListView(
              children: list,
              physics: const BouncingScrollPhysics(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                primaryColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
