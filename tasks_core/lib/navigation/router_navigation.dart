import 'package:flutter/material.dart';
import 'app_router.dart';
import 'geolocation.dart';

class Navigation extends GeoLocationResolver {
  void navigateLogin(context) {
    Navigator.of(context).pushNamed(RouterNavigation.LOGIN_SCREEN);
    print("Navigate to Login called");
  }

  void navigateHome(context) {
    Navigator.of(context).pushNamed(RouterNavigation.HOME_SCREEN);
    print("Navigate To Home called");
  }

  void navigateHomeAddTask(context) {
    Navigator.of(context).pushNamed(RouterNavigation.HOME_ADD_TASK_SCREEN);
    print("Navigate To Home  Add Task called");
  }

  void navigateHomeEditTask(context, taskVO) {
    Navigator.of(context)
        .pushNamed(RouterNavigation.HOME_EDIT_TASK_SCREEN, arguments: taskVO);
    print("Navigate to Home Edit Task called");
  }

  void navigateCreateAccount(context) {
    Navigator.of(context)
        .pushNamed(RouterNavigation.LOGIN_SCREEN_CREATE_ACCOUNT);
    print("Navigate to Create Account called");
  }

  void navigateSignupLogin(context) {
    Navigator.of(context)
        .pushNamed(RouterNavigation.LOGIN_SCREEN_SIGNUP_ACCOUNT);
    print("Navigate to Login SignUp called");
  }

  void popBackStack(context) {
    Navigator.of(context).pop();
  }
}
