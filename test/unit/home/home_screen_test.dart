import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tasks_core/core/data/model/weather_data_model.dart';
@GenerateNiceMocks([MockSpec<HomePresenter>(), MockSpec<HomeView>()])
import 'package:tasks_flutter_one/features/home/contract/home_contract.dart';
import 'package:tasks_flutter_one/features/home/data/model/task_vo.dart';
@GenerateNiceMocks([MockSpec<HomeRepository>()])
import 'package:tasks_flutter_one/features/home/data/repository/home_repository.dart';
@GenerateNiceMocks([MockSpec<HomePresenterImpl>()])
import 'package:tasks_flutter_one/features/home/presenter/home_presenter.dart';

import 'home_screen_test.mocks.dart';

void main() {
  var homePresenterMock = MockHomePresenter();
  var homePresenterRepositoryMock = MockHomeRepository();
  var homePresenterImplMock = MockHomePresenterImpl();
  var homeViewMock = MockHomeView();

  test(
      'should call navigate to homeAddTaskPage when navigateToHomeAddTaskScreen of contract presenter has called',
      () {
    // WHEN
    when(homePresenterMock.navigateToHomeAddTaskScreen(null)).thenAnswer((_) {
      homePresenterImplMock.navigateHomeAddTask(null);
    });
    homePresenterMock.navigateToHomeAddTaskScreen(null);

    // THEN
    verify(homePresenterImplMock.navigateHomeAddTask(null));
  });

  test(
      'should call navigate to homeEditTaskPage when navigateToEditTaskPage of contract presenter has called',
      () {
    // GIVEN
    var taskVOMock = TaskVO("", "", "", "", false, "213", "", "", "1231");

    // WHEN
    when(homePresenterMock.navigateToEditTaskPage(null, taskVOMock))
        .thenAnswer((_) {
      homePresenterImplMock.navigateHomeEditTask(null, taskVOMock);
    });

    homePresenterMock.navigateToEditTaskPage(null, taskVOMock);

    // THEN
    verify(homePresenterMock.navigateToEditTaskPage(null, taskVOMock));
  });

  test(
      "shoud call delete dialog when on change long press has called with flag equals true",
      () {
    // WHEN
    when(homePresenterMock.onChangeLongPress(true)).thenAnswer((_) {
      homeViewMock.showOnDeleteDialog(true);
    });

    homePresenterMock.onChangeLongPress(true);

    // THEN
    verify(homeViewMock.showOnDeleteDialog(true));
  });

  test('should call recovery all tasks when init method has called', () {
    // WHEN
    when(homePresenterMock.init()).thenAnswer((_) {
      homePresenterImplMock.giveAllTasks();
    });

    homePresenterMock.init();

    // THEN
    verify(homePresenterImplMock.giveAllTasks());
  });

  test('should call getCurrentWeather', () {
    // WHEN
    when(homePresenterImplMock.getCurrentWeather());

    homePresenterImplMock.getCurrentWeather();

    // THEN
    verify(homePresenterImplMock.getCurrentWeather());
  });

  test('should call getCurrentWeather and validate return of api', () {
    // GIVEN
    var lat = 14.0432;
    var lng = 32.4734;

    // WHEN
    when(homePresenterRepositoryMock.getWeatherCurrent(lat, lng)).thenAnswer((realInvocation) => Future<CurrentWeather>.value(
      CurrentWeather(current: CurrentDataWeather(temp_c: 19.8,temp_f: 46.43, conditionDataWeather: ConditionDataWeather(
        text: "Parcialmente Nublado",
        icon: "https://fakeicon.com"
      )))
    ));

    homePresenterImplMock.getCurrentWeather();

    // THEN
    homePresenterRepositoryMock.getWeatherCurrent(lat, lng).then((currentWeather) => {
      expect(19.8,currentWeather.current?.temp_c),
      expect(46.43, currentWeather.current?.temp_f),
      expect("Parcialmente Nublado", currentWeather.current?.conditionDataWeather?.text),
      expect("https://fakeicon.com", currentWeather.current?.conditionDataWeather?.icon)
    });

    verify(homePresenterImplMock.getCurrentWeather());
  });

  test(
      'should delete task with successful when value returned status code ok of delete task repository',
      () {
    // GIVEN
    var taskVOMock = TaskVO("", "", "", "", false, "213", "", "", "1231");

    // WHEN
    when(homePresenterMock.onClickDeleteTask(taskVOMock)).thenAnswer((_) {
      homeViewMock.showOrHideLoading(true);
      homeViewMock.showMessage("Tarefa deletada com sucesso");
      homeViewMock.showOrHideLoading(false);
    });

    when(homePresenterRepositoryMock.deleteTask(taskVOMock.uniqueId!))
        .thenAnswer((_) => Future<Response>.value(Response("", 200)));

    homePresenterMock.onClickDeleteTask(taskVOMock);

    // THEN
    homePresenterRepositoryMock
        .deleteTask(taskVOMock.uniqueId!)
        .then((value) => {expect(value.statusCode, 200)});

    verifyInOrder([
      homePresenterMock.onClickDeleteTask(taskVOMock),
      homeViewMock.showOrHideLoading(true),
      homeViewMock.showMessage("Tarefa deletada com sucesso"),
      homeViewMock.showOrHideLoading(false),
    ]);
  });

  test(
      'should dont delete task with unsuccessful when value returned status error of delete task repository',
      () {
    // GIVEN
    var taskVOMock = TaskVO("", "", "", "", false, "213", "", "", "1231");

    // WHEN
    when(homePresenterMock.onClickDeleteTask(taskVOMock)).thenAnswer((_) {
      homeViewMock.showOrHideLoading(true);
      homeViewMock
          .showMessage("Não foi possivel deletar a tarefa, tente novamente!");
      homeViewMock.showOrHideLoading(false);
    });

    when(homePresenterRepositoryMock.deleteTask(taskVOMock.uniqueId!))
        .thenAnswer((_) => Future<Response>.value(Response("", 400)));

    homePresenterMock.onClickDeleteTask(taskVOMock);

    // THEN
    homePresenterRepositoryMock
        .deleteTask(taskVOMock.uniqueId!)
        .then((value) => {expect(value.statusCode, 400)});

    verifyInOrder([
      homePresenterMock.onClickDeleteTask(taskVOMock),
      homeViewMock.showOrHideLoading(true),
      homeViewMock
          .showMessage("Não foi possivel deletar a tarefa, tente novamente!"),
      homeViewMock.showOrHideLoading(false),
    ]);
  });
}
