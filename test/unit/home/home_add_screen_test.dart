import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tasks_flutter_one/features/home/contract/home_add_task_contract.dart';
import 'package:tasks_flutter_one/features/home/data/model/task_vo.dart';
@GenerateNiceMocks(
    [MockSpec<HomeAddTaskPresenter>(), MockSpec<HomeAddTaskView>()])
@GenerateNiceMocks([MockSpec<HomeRepository>()])
import 'package:tasks_flutter_one/features/home/data/repository/home_repository.dart';
@GenerateNiceMocks([MockSpec<HomeAddTaskPresenterImpl>()])
import 'package:tasks_flutter_one/features/home/presenter/home_add_task_presenter.dart';

import 'home_add_screen_test.mocks.dart';

void main() {
  var homePresenterAddMock = MockHomeAddTaskPresenter();
  var homeViewAddMock = MockHomeAddTaskView();

  test('should show datePicker view when onClickDateButton has called', () {
    // WHEN
    when(homePresenterAddMock.onClickDateButton()).thenAnswer((_) {
      homeViewAddMock.showPageDatePicker();
    });

    homePresenterAddMock.onClickDateButton();

    // THEN
    verify(homeViewAddMock.showPageDatePicker());
  });

  test('should show selected date when datepicker has data', () async {
    // GIVEN
    final DateTime pickedDate = DateTime.now();

    // WHEN
    when(homePresenterAddMock.onSaveDateSelected(pickedDate)).thenAnswer((_) {
      homeViewAddMock.showDatePickedSelected(pickedDate.toString());
    });

    homePresenterAddMock.onSaveDateSelected(pickedDate);

    // THEN
    verify(homeViewAddMock.showDatePickedSelected(pickedDate.toString()));
  });

  test('should show expand forms when onClickExpandItemsForm called', () async {
    // WHEN
    when(homePresenterAddMock.onClickExpandItemsForm(true)).thenAnswer((_) {
      homeViewAddMock.setupExpandItems(true);
    });

    homePresenterAddMock.onClickExpandItemsForm(true);

    // THEN
    verify(homeViewAddMock.setupExpandItems(true));
  });

  test(
      'should create a task when onClickAddTask called and title and description is not empty', () {
    // GIVEN
    var mockTask = TaskVO(
        "fake title",
        "fake description",
        "Baixa",
        "1244",
        false,
        "213213",
        "21382.1231",
        "21321.12313",
        "213123");

    // WHEN
    when(homePresenterAddMock.onClickAddTask(
        mockTask.title, mockTask.description, mockTask.date, mockTask.favorite,
        mockTask.latitude, mockTask.longitude)).thenAnswer((_) {
      homeViewAddMock.showMessage("Tarefa criada com sucesso!");
    });

    homePresenterAddMock.onClickAddTask(
        mockTask.title, mockTask.description, mockTask.date, mockTask.favorite,
        mockTask.latitude, mockTask.longitude);

    // THEN
    verify(homeViewAddMock.showMessage("Tarefa criada com sucesso!"));
  });
}
