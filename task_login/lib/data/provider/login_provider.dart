import 'package:tasks_core/base_provider.dart';

class LoginProvider extends BaseProvider {
  var showFeedBackMessage = "";

  void onShowFeedBackMessage(String message) {
    showFeedBackMessage = message;
    notifyListeners();
  }

}
