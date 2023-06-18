import 'dart:convert';

import 'package:tasks_core/base_provider.dart';
import 'package:tasks_core/navigation/router_navigation.dart';
import 'package:tasks_flutter_one/features/home/contract/home_contract.dart';
import 'package:tasks_flutter_one/features/home/data/model/task_vo.dart';
import '../data/repository/home_repository.dart';

class HomePresenterImpl extends Navigation implements HomePresenter {
  final HomeView _view;
  final HomeRepository _homeRepository;

  HomePresenterImpl(this._view, this._homeRepository);

  @override
  void dispose() {}

  @override
  getView() => _view;

  @override
  void init() {
    _giveAllTasks();
  }

  _giveAllTasks() {
    List<TaskVO> tasksVO = [];
    _homeRepository.getAllTasks().then((value) => {
          (jsonDecode(value.body)).forEach((key, value) {
            tasksVO.add(TaskVO.fromJson(value, key));
          }),
          _view.setupTasksView(tasksVO)
        });
  }

  @override
  void onCLickAddTask() {
    _view.sendCallNavigateHome();
  }

  @override
  void navigateToHomeAddTaskScreen(context) {
    navigateHomeAddTask(context);
  }

  @override
  void onClickDeleteTask(TaskVO taskVO) {
    _view.showOrHideLoading(true);
    _homeRepository.deleteTask(taskVO.uniqueId!).then((value) => {
          if (value.statusCode == 200)
            {
              _view.showMessage("Tarefa deletada com sucesso"),
              _view.showOrHideLoading(false),
              init()
            }
          else
            {
              _view.showError(
                  "Não foi possivel deletar a tarefa, tente novamente!"),
              _view.showOrHideLoading(false)
            }
        });
  }

  @override
  void navigateToEditTaskPage(context, TaskVO taskVO) {
    navigateHomeEditTask(context, taskVO);
  }

  @override
  void onChangeLongPress(bool flag) {
    _view.showOnDeleteDialog(flag);
  }

  @override
  void setProvider(BaseProvider baseProvider) {}
}
