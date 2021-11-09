import 'package:quasar_music/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  int idx = 0;

  void updateIdx(int index) {
    idx = index;
    notifyListeners();
  }
}
