import 'dart:convert';

import 'package:tasks_flutter_one/features/home/contract/home_contract.dart';
import 'package:tasks_flutter_one/features/home/data/model/task_vo.dart';
import '../../../core/router_navigation.dart';
import '../data/repository/home_repository.dart';

class HomePresenterImpl extends Navigation implements HomePresenter {
  HomeView _view;
  HomeRepository _homeRepository;

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
    List<TaskVO> taskVO = [];

    _homeRepository.getAllTasks().then((value) => {
          (jsonDecode(value.body)).forEach((key, value) {
            taskVO.add(TaskVO.fromJson(value, key));
          }),
          _view.setupTasksView(taskVO)
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
}
