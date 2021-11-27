class SongModel {
  final int? id;
  final String? type;
  final String? link;
  final String? title;
  final String? previewUrl;
  final String? artworkRawUrl;
  final String? artistName;
  final String? albumName;

  SongModel(
      {this.id,
      this.type,
      this.link,
      this.title,
      this.previewUrl,
      this.artworkRawUrl,
      this.artistName,
      this.albumName});

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
        id: json['id'],
        type: json['type'],
        link: json['link'],
        title: json['title'],
        previewUrl: json['preview'],
        artworkRawUrl: json['album'] != null ? json['album']['cover'] : "",
        artistName: json['artist']['name'],
        albumName: json['album'] != null ? json['album']['title'] : "");
  }

  String artworkUrl(int size) {
    return this.artworkRawUrl!.replaceAll('{w}x{h}', "${size}x$size");
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'link': link,
      'title': title,
      'previewUrl': previewUrl,
      'artworkRawUrl': artworkRawUrl,
      'artistName': artistName,
      'albumName': albumName,
    };
  }
}
