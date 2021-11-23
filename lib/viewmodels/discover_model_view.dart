import 'package:quasar_music/models/album_model.dart';
import 'package:quasar_music/models/chart_model.dart';
import 'package:quasar_music/services/song_service.dart';

import 'base_model.dart';

class DiscoverModelView extends BaseModel {
  SongService songService = SongService.instance;

  Future<DiscoverData> fetchDiscoverList() async {
    final chart = await songService.fetchAlbumsAndSongsTopChart();
    final List<AlbumModel> albums = [];

    final album3 =
        await songService.fetchAlbumById(chart.albumChart!.albums![0].id!);

    albums.add(album3);

    return DiscoverData(
      albums: albums,
      chart: chart,
    );
  }
}

class DiscoverData {
  late ChartModel? chart;
  late List<AlbumModel>? albums;

  DiscoverData({this.chart, this.albums});
}
