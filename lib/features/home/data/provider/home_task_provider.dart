import 'package:flutter/cupertino.dart';
import 'package:tasks_core/base_provider.dart';
import 'package:tasks_flutter_one/features/home/data/model/task_vo.dart';

class HomeTaskProvider extends BaseProvider {
  var onDoubleTapTaskCard = false;
  var taskSelected;
  var titleTaskEdit = "";
  var showLoadingButton = true;
  var showExpandItem = true;
  var showLocateEditDialog = false;
  List<TaskVO>? tasksList;

  void onChangeTaskTitleEdit(String taskTitle) {
    titleTaskEdit = taskTitle;
    notifyListeners();
  }

  void onChangeLongPress(bool flag) {
    onDoubleTapTaskCard = flag;
    notifyListeners();
  }

  void onChangeTaskSelected(TaskVO task) {
    taskSelected = task;
    notifyListeners();
  }

  void onChangeTasksList(List<TaskVO> tasks) {
    tasksList = tasks;
    notifyListeners();
  }

  void onShowLoadingButton(bool flag) {
    showLoadingButton = flag;
    notifyListeners();
  }

  void onShowExpandItem(bool flag) {
    showExpandItem = flag;
    notifyListeners();
  }

  void onShowEditAlertLocateDialog(bool flag) {
    showLocateEditDialog = flag;
    notifyListeners();
  }
}
