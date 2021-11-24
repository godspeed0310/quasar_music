import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quasar_music/models/album_model.dart';
import 'package:quasar_music/models/artist_model.dart';
import 'package:quasar_music/models/chart_model.dart';
import 'package:quasar_music/models/song_model.dart';

class SongService {
  SongService._privateConstructor();

  static final SongService instance = SongService._privateConstructor();
  static const BASE_URL = 'https://api.deezer.com';
  static const _SONG_URL = '$BASE_URL/track';
  static const _ALBUM_URL = '$BASE_URL/album';
  static const _CHART_URL = '$BASE_URL/chart';
  static const _ARTIST_URL = '$BASE_URL/artist';
  static const JWT_KEY = 'frfWq9f6lL3RhBjFR6seaFb8N1RF0Pc56KQiwgJy3mvP0gO3CIA';

  Future<dynamic> _fetchJson(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $JWT_KEY'},
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<SongModel> fetchSongById(String id) async {
    final json = await _fetchJson('$_SONG_URL/$id');
    return SongModel.fromJson(json);
  }

  Future<AlbumModel> fetchAlbumById(String id) async {
    final json = await _fetchJson('$_ALBUM_URL/$id');
    return AlbumModel.fromJson(json);
  }

  Future<ArtistModel> fetchArtistByid(int id) async {
    final jsonArtist = await _fetchJson('$_ARTIST_URL/$id');
    final trackLink = jsonArtist['tracklist'];
    final jsonAlbum = await _fetchJson('$_ARTIST_URL/$id/albums');
    final jsonSong = await _fetchJson('$trackLink');
    return ArtistModel.fromJson(jsonArtist, jsonSong, jsonAlbum);
  }

  Future<ChartModel> fetchAlbumsAndSongsTopChart() async {
    final url = '$_CHART_URL';
    final json = await _fetchJson(url);
    final songChartJson = json['tracks'];
    final songChart = SongChart.fromJson(songChartJson);

    final albumChartJson = json['albums'];
    final albumChart = AlbumChart.fromJson(albumChartJson);

    final chart = ChartModel(
      songChart: songChart,
      albumChart: albumChart,
    );
    return chart;
  }
}
