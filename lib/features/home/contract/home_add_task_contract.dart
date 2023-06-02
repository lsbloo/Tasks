import 'package:flutter/cupertino.dart';
import 'package:tasks_flutter_one/core/base_presenter.dart';
import 'package:tasks_flutter_one/core/base_view.dart';

abstract class HomeAddTaskPresenter extends BasePresenter {
  void onClickDateButton();

  void onSaveDateSelected(DateTime pickedDate);

  void onClickExpandItemsForm();

  void onClickAddTask(String title, String description, String date, bool isFav,
      String latitude, String longitude);

  void onClickLocationIcon();

  void onGiveLocationUser();

  void setControlPopPage(bool flag);

  bool controlPage();
}

abstract class HomeAddTaskView extends BaseView {
  void showPageDatePicker();

  void showDatePickedSelected(String date);

  void setupExpandItems();

  void setupDialogConfirmLocation();

  void setupMapWithLocate(String lat, String long);
}
