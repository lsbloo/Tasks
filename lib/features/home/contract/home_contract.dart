import 'package:tasks_flutter_one/core/base_presenter.dart';
import 'package:tasks_flutter_one/core/base_view.dart';

import '../data/model/task_vo.dart';

abstract class HomePresenter extends BasePresenter {
  void navigateToHomeAddTaskScreen(context);

  void onCLickAddTask();

  void onClickDeleteTask(TaskVO taskVO);
}

abstract class HomeView extends BaseView {
  void sendCallNavigateHome();

  void setupTasksView(List<TaskVO> tasks);
}
