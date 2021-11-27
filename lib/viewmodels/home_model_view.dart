import 'package:acr_cloud_sdk/acr_cloud_sdk.dart' as sm;
import 'package:quasar_music/locator.dart';
import 'package:quasar_music/models/song_model.dart';
import 'package:quasar_music/services/firestore_service.dart';
import 'package:quasar_music/services/song_service.dart';

import 'base_model.dart';

class HomeModelView extends BaseModel {
  HomeModelView() {
    initAcr();
    isLiked = false;
  }

  final sm.AcrCloudSdk acr = sm.AcrCloudSdk();
  final SongService songService = SongService.instance;
  late SongModel currentSong;
  bool isRecognizing = false;
  late bool success;
  late bool isLiked;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  Future<void> initAcr() async {
    try {
      acr
        ..init(
          host: 'identify-eu-west-1.acrcloud.com',
          accessKey: '03a75594ca449622d3be6e49031dccc4',
          accessSecret: 'tnfP2xafhlD6XoOrxWku8d9gsNpD005F284Ey51r',
          setLog: false,
        )
        ..songModelStream.listen(searchSong);
      success = false;
    } catch (e) {
      print(e.toString());
    }
  }

  void searchSong(sm.SongModel model) async {
    final metaData = model.metadata;
    if (metaData != null && metaData.music!.isNotEmpty) {
      final trackId = metaData.music![0].externalMetadata!.deezer!.track!.id;
      print('On recog init $success');
      try {
        final result = await songService.fetchSongById(trackId!);
        currentSong = result;
        success = true;
        notifyListeners();
      } catch (e) {
        isRecognizing = false;
        success = false;
        notifyListeners();
      }
    }

    stopRecognising();
    isRecognizing = false;
    success = true;
    notifyListeners();
  }

  Future<void> startRecognising() async {
    isRecognizing = true;
    success = false;
    notifyListeners();
    try {
      await acr.start();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> stopRecognising() async {
    isRecognizing = false;
    success = false;
    notifyListeners();
    try {
      await acr.stop();
    } catch (e) {
      print(e.toString());
    }
  }

  addToFavourites() async {
    await _firestoreService.addToFav(currentSong);
  }

  removeFromFavourites() async {
    await _firestoreService.removeFromFav(currentSong);
  }

  updateSuccessState(bool value) {
    success = value;
    notifyListeners();
  }

  toggleLike() {
    isLiked = !isLiked;
    !isLiked ? removeFromFavourites() : addToFavourites();
    notifyListeners();
  }
}
