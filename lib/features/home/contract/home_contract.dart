

import 'package:tasks_core/core/base_presenter.dart';
import 'package:tasks_core/core/base_view.dart';
import 'package:tasks_core/core/data/model/weather_data_model.dart';

import '../data/model/task_vo.dart';

abstract class HomePresenter extends BasePresenter {
  void navigateToHomeAddTaskScreen(context);

  void onCLickAddTask();

  void onClickDeleteTask(TaskVO taskVO);

  void navigateToEditTaskPage(context,TaskVO taskVO);

  void onChangeLongPress(bool flag);
}

abstract class HomeView extends BaseView {
  void sendCallNavigateHome();

  void setupTasksView(List<TaskVO> taskVO);

  void showOnDeleteDialog(bool flag);

  void setupViewWeather(CurrentWeather weather);
}
