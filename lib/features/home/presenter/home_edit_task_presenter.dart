import 'package:tasks_flutter_one/core/router_navigation.dart';
import 'package:tasks_flutter_one/features/home/contract/home_edit_task_contract.dart';
import 'package:tasks_flutter_one/features/home/data/model/task_vo.dart';
import 'package:tasks_flutter_one/features/home/data/repository/home_repository.dart';

class HomeEditPresenter extends Navigation implements HomeEditTaskPresenter {
  HomeEditPageView _view;
  HomeRepository _homeRepository;
  String locate = "";

  HomeEditPresenter(this._view, this._homeRepository);

  @override
  void dispose() {}

  @override
  getView() => _view;

  @override
  void init() {}

  @override
  void onClickEditTask(TaskVO taskIdSelected, String title, String description,
      String crit, bool isFav) {
    String lat = "";
    String long = "";
    if (locate != "") {
      lat = locate.split(":")[0];
      long = locate.split(":")[1];
    }

    TaskVO taskVO = TaskVO(
        title,
        description,
        crit,
        taskIdSelected.date,
        isFav,
        taskIdSelected.id,
        lat != "" ? lat : taskIdSelected.latitude,
        long != "" ? long : taskIdSelected.longitude,
        taskIdSelected.uniqueId);
    _view.showOrHideLoading(false);
    _homeRepository
        .updateTask(taskVO, taskIdSelected.uniqueId!)
        .then((value) => {
              if (value.statusCode == 200)
                {
                  _view.showOrHideLoading(true),
                  _view.showMessage("Tarefa editada com sucesso!"),
                  _view.popPage()
                }
              else
                {
                  _view.showOrHideLoading(true),
                  _view.showMessage(
                      "Não foi possivel editar a tarefa, tente novamente!")
                }
            });
  }

  @override
  void onClickLocationIcon(bool flag) {
    _view.setupDialogConfirmLocation(flag);
  }

  @override
  void onGiveLocationUser() {
    if (locate == "") {
      _view.showMessage("Obtendo Localização...");
      _view.showOrHideLoading(true);
      getLocation().then((value) => {
        if(value.isNotEmpty) {
          _view.showMessage(
              "Localização encontrada. Não se preocupe iremos adicionar sua localização a tarefa!"),
          locate = value,
          _view.showOrHideLoading(false)
        } else {
          _view.showMessage("Ocorreu um erro ao tentar obter sua localização, tente novamente!")
        }
          });
    }
  }
}
