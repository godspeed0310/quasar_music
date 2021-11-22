import 'package:acr_cloud_sdk/acr_cloud_sdk.dart';
import 'package:quasar_music/models/deezer_song_model.dart';
import 'package:quasar_music/viewmodels/base_model.dart';

import '../services/song_service.dart';

class HomeModelView extends BaseModel {
  late AcrCloudSdk acrCloudSdk = AcrCloudSdk();
  final SongService songService = SongService();
  late DeezerSongModel currentSong;
  bool isRecognising = false;
  bool success = false;

  initAcr() async {
    await acrCloudSdk
      ..init(
        host: 'identify-eu-west-1.acrcloud.com',
        accessKey: '03a75594ca449622d3be6e49031dccc4',
        accessSecret: 'tnfP2xafhlD6XoOrxWku8d9gsNpD005F284Ey51r',
        setLog: true,
      )
      ..songModelStream.listen(searchSong);
  }

  searchSong(SongModel songModel) async {
    final metaData = songModel.metadata;
    if (metaData != null && metaData.music!.isNotEmpty) {
      final trackId = metaData.music?[0].externalMetadata?.deezer?.track?.id;
      try {
        final result = await songService.getTrack(trackId);
        currentSong = result;
        success = true;
        print(result);
        notifyListeners();
      } catch (e) {
        isRecognising = false;
        success = false;
        notifyListeners();
      }
    }
  }

  Future<void> startRecognizing() async {
    isRecognising = true;
    success = false;
    notifyListeners();
    try {
      await acrCloudSdk.start();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> stopRecognizing() async {
    isRecognising = false;
    success = false;
    notifyListeners();
    try {
      await acrCloudSdk.stop();
    } catch (e) {
      print(e.toString());
    }
  }
}
