import 'package:tasks_core/navigation/router_navigation.dart';
import 'package:tasks_flutter_one/features/home/contract/home_add_task_contract.dart';
import 'package:tasks_flutter_one/features/home/data/model/task_vo.dart';
import 'package:tasks_flutter_one/features/home/data/repository/home_repository.dart';
import 'package:tasks_flutter_one/features/utils/extensions.dart';

class HomeAddTaskPresenterImpl extends Navigation
    implements HomeAddTaskPresenter {
  final HomeAddTaskView _view;
  final HomeRepository _homeRepository;
  String locate = "";
  bool _popPageOK = false;

  HomeAddTaskPresenterImpl(this._view, this._homeRepository);

  @override
  void dispose() {}

  @override
  getView() => _view;

  @override
  void init() {}

  @override
  void onClickDateButton() {
    print("onClick dateButton called");
    _view.showPageDatePicker();
  }

  @override
  void onSaveDateSelected(DateTime pickedDate) {
    print(pickedDate);
    String dateTime =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";

    _view.showDatePickedSelected(dateTime);
  }

  @override
  void onClickExpandItemsForm(bool flag) {
    _view.setupExpandItems(flag);
  }

  @override
  void onClickAddTask(String title, String description, String date, bool isFav,
      String latitude, String longitude) {
    String datePicked1 = "";
    if (title.isEmpty || description.isEmpty) {
      _view.showError("Digite os campos corretamente!");
    } else {
      if (date == "Hoje") {
        DateTime dateTime = DateTime.now();
        String datePicked =
            "${dateTime.day}/${dateTime.month}/${dateTime.year}";
        datePicked1 = datePicked;
      } else {
        datePicked1 = date;
      }
      if (locate != "") {
        _saveARemoteTask(TaskVO(title, description, "baixa", datePicked1, isFav,
            "".generateUuid(), locate.split(":")[0], locate.split(":")[1], ""));
      } else {
        _saveARemoteTask(TaskVO(title, description, "baixa", datePicked1, isFav,
            "".generateUuid(), "", "", ""));
      }
    }
  }

  _saveARemoteTask(TaskVO taskVO) {
    _view.showOrHideLoading(true);
    _homeRepository.saveTask(taskVO).then((value) => {
          if (value.statusCode == 200)
            {_view.showMessage("Tarefa criada com sucesso!"), _view.popPage()}
          else
            {_view.showError("Ocorreu um erro, tente novamente!")},
          _view.showOrHideLoading(false)
        });
  }

  @override
  void onClickLocationIcon() {
    _view.setupDialogConfirmLocation();
  }

  @override
  void onGiveLocationUser() {
    if (locate == "") {
      _view.showMessage("Obtendo Localização...");
      _view.showOrHideLoading(true);
      getLocation().then((value) => {
            _view.showMessage(
                "Localização encontrada, clique no icone mapa para visualizar. Não se preocupe iremos adicionar sua localização a tarefa!"),
            locate = value,
            _view.showOrHideLoading(false)
          });
    } else {
      _view.setupMapWithLocate(locate.split(":")[0], locate.split(":")[1]);
    }
  }

  @override
  void setControlPopPage(bool flag) {
    _popPageOK = flag;
  }

  @override
  bool controlPage() {
    return _popPageOK;
  }
}
