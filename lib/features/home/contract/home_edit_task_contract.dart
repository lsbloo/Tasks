import 'package:tasks_core/core/base_presenter.dart';
import 'package:tasks_core/core/base_view.dart';
import 'package:tasks_flutter_one/features/home/data/model/task_vo.dart';

abstract class HomeEditTaskPresenter extends BasePresenter {
  void onClickEditTask(TaskVO taskIdSelected, String title, String description,
      String crit, bool isFav);

  void onClickLocationIcon(bool flag);

  void onGiveLocationUser();
}

abstract class HomeEditPageView extends BaseView {
  void refresh();

  void setupDialogConfirmLocation(bool flag);
}
