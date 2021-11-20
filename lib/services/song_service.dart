import 'package:dio/dio.dart';
import 'package:quasar_music/models/deezer_song_model.dart';

class SongService {
  late Dio _dio;

  SongService() {
    BaseOptions options = BaseOptions(
        receiveTimeout: 10000,
        connectTimeout: 10000,
        baseUrl: 'https://api.deezer.com/track/');
    _dio = Dio(options);
  }

  Future<DeezerSongModel> getTrack(id) async {
    try {
      final response = await _dio.get(
        '$id',
        options: Options(headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json;charset=UTF-8',
        }),
      );
      DeezerSongModel result = DeezerSongModel.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null) {
        throw 'An error occured';
      } else {
        print(e.error);
        throw e.error;
      }
    }
  }
}
