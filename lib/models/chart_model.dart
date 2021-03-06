import 'album_model.dart';
import 'song_model.dart';

class ChartModel {
  final AlbumChart? albumChart;
  final SongChart? songChart;

  ChartModel({this.albumChart, this.songChart});
}

class AlbumChart {
  final int? position;
  final String? link;
  final String? title;
  final List<AlbumModel>? albums;

  AlbumChart({this.position, this.link, this.title, this.albums});

  factory AlbumChart.fromJson(Map<String, dynamic> json) {
    final albumJson = json['data'] as List;
    final albums = albumJson.map((s) => AlbumModel.fromJson(s)).toList();

    return AlbumChart(
        position: albumJson[0]['position'],
        link: albumJson[0]['link'],
        title: albumJson[0]['title'],
        albums: albums);
  }
}

class SongChart {
  final int? rank;
  final String? link;
  final String? title;
  final List<SongModel>? songs;

  SongChart({this.rank, this.link, this.title, this.songs});

  factory SongChart.fromJson(Map<String, dynamic> json) {
    final songJson = json['data'] as List;
    final songs = songJson.map((s) => SongModel.fromJson(s)).toList();

    return SongChart(
        rank: songJson[0]['rank'],
        link: songJson[0]['link'],
        title: songJson[0]['title'],
        songs: songs);
  }
}
