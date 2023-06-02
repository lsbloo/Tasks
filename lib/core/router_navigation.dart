import 'package:flutter/material.dart';
import 'package:tasks_flutter_one/core/geolocation.dart';
import 'package:tasks_flutter_one/navigation/app_router.dart';

class Navigation extends GeoLocationResolver {
  void navigateHome(context) {
    Navigator.of(context).pushNamed(RouterNavigation.HOME_SCREEN);
    print("Navigate To Home called");
  }

  void navigateHomeAddTask(context) {
    Navigator.of(context).pushNamed(RouterNavigation.HOME_ADD_TASK_SCREEN);
    print("Navigate To Home  Add Task called");
  }

  void popBackStack(context) {
    Navigator.of(context).pop();
  }
}
