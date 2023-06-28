import 'package:tasks_core/base_provider.dart';

class LoginProvider extends BaseProvider {
  var showFeedBackMessage = "";

  var showLoading = false;

  void onShowFeedBackMessage(String message) {
    showFeedBackMessage = message;
    notifyListeners();
  }

  void onShowLoadingPage(bool flag) {
    showLoading = flag;
    notifyListeners();
  }
}
