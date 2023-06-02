import 'package:flutter/cupertino.dart';

class HomeTaskProvider extends ChangeNotifier {
  var onDoubleTapTaskCard = false;

  void onChangeLongPress(bool flag) {
    onDoubleTapTaskCard = flag;
    notifyListeners();
  }
}
