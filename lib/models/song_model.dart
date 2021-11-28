class SongModel {
  int? id;
  String? type;
  String? link;
  String? title;
  String? previewUrl;
  String? artworkRawUrl;
  String? artistName;
  String? albumName;

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

  SongModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    type = data['type'];
    link = data['link'];
    title = data['title'];
    previewUrl = data['previewUrl'];
    artworkRawUrl = data['artworkRawUrl'];
    artistName = data['artistName'];
    albumName = data['albumName'];
  }
}
