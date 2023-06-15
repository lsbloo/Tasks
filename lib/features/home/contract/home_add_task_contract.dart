

import 'package:tasks_core/core/base_presenter.dart';
import 'package:tasks_core/core/base_view.dart';

abstract class HomeAddTaskPresenter extends BasePresenter {
  void onClickDateButton();

  void onSaveDateSelected(DateTime pickedDate);

  void onClickExpandItemsForm(bool flag);

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

  void setupExpandItems(bool flag);

  void setupDialogConfirmLocation();

  void setupMapWithLocate(String lat, String long);
}
