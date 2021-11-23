import 'song_model.dart';

class AlbumModel {
  final String? id;
  final String? type;
  final String? link;
  final String? title;
  final String? artworkRawUrl;
  final String? artistName;
  final List<SongModel>? songs;
  final int? artistId;

  AlbumModel(
      {this.id,
      this.type,
      this.link,
      this.title,
      this.artworkRawUrl,
      this.artistName,
      this.songs,
      this.artistId});

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    final List<SongModel> songs = [];
    int artistId = 0;

    final relationshipJSON =
        json['tracks'] != null ? json['tracks']['data'] as List : null;
    if (relationshipJSON != null) {
      final tracksJSON = relationshipJSON;
      songs.addAll(tracksJSON.map((s) => SongModel.fromJson(s)));

      artistId = tracksJSON[0]['artist']['id'];
    }

    String title = '';
    String artworkRawUrl = '';
    String artistName = '';

    final attributesJSON = json;
    if (attributesJSON != null) {
      title = attributesJSON['title'];
      artworkRawUrl = attributesJSON['cover'];
      artistName = attributesJSON['artist'] != null
          ? attributesJSON['artist']['name']
          : "";
    }

    return AlbumModel(
        id: attributesJSON['id'].toString(),
        type: attributesJSON['type'],
        link: attributesJSON['link'],
        title: title,
        artworkRawUrl: artworkRawUrl,
        artistName: artistName,
        songs: songs,
        artistId: artistId);
  }

  String artworkUrl(int size) {
    return this.artworkRawUrl!.replaceAll('{w}x{h}', "${size}x$size");
  }
}
