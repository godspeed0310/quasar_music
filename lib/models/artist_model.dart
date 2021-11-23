import 'song_model.dart';
import 'album_model.dart';

class ArtistModel {
  final int? id;
  final String? type;
  final String? link;
  final String? name;

  final List<SongModel>? songs;
  final List<AlbumModel>? albums;

  ArtistModel(
      {this.id, this.type, this.link, this.name, this.songs, this.albums});

  factory ArtistModel.fromJson(Map<String, dynamic> json,
      Map<String, dynamic>? jsonSong, Map<String, dynamic>? jsonAlbum) {
    final List<SongModel> songs = [];
    final List<AlbumModel> albums = [];

    final relationshipJSON = jsonSong != null ? jsonSong['data'] as List : null;
    if (relationshipJSON != null) {
      final songsJSON = relationshipJSON;
      if (songsJSON != null) {
        songs.addAll((songsJSON).map((s) => SongModel.fromJson(s)));
      }

      final albumJSON = jsonAlbum!['data'] as List;
      if (albumJSON != null) {
        albums.addAll((albumJSON).map((s) => AlbumModel.fromJson(s)));
      }
    }

    return ArtistModel(
        id: json['id'],
        type: json['type'],
        link: json['link'],
        name: json['name'],
        albums: albums,
        songs: songs);
  }
}
