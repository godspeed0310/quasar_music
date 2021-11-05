import 'base_model.dart';

class InputFieldViewModel extends BaseModel {
  bool isVisible = false;

  toggleVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }
}
