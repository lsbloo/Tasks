import 'package:task_login/page/login_screen_page.dart';
import 'package:task_login/page/login_create_screen_page.dart';
import 'package:task_login/page/login_signup_screen_page.dart';
import 'package:tasks_flutter_one/features/home/page/home_screen_add_task_page.dart';
import 'package:tasks_flutter_one/features/home/page/home_screen_edit_task_page.dart';
import 'package:tasks_flutter_one/features/home/page/home_screen_page.dart';
import 'package:tasks_flutter_one/features/splash/page/splash_screen_page.dart';

class RouterNavigation {
  static const SPLASH_SCREEN = '/';
  static const LOGIN_SCREEN = '/login';
  static const LOGIN_SCREEN_CREATE_ACCOUNT = '/login/create';
  static const LOGIN_SCREEN_SIGNUP_ACCOUNT = '/login/signup';
  static const HOME_SCREEN = '/home';
  static const HOME_ADD_TASK_SCREEN = '/home/addtask';
  static const HOME_EDIT_TASK_SCREEN = '/home/edittask';

  static final ROUTERS = {
    '/': (context) => const SplashScreenPage(),
    '/login': (context) => const LoginScreenPage(),
    '/login/create': (context) => const LoginCreateScreenPage(),
    '/login/signup': (context) => const LoginSignUpScreenPage(),
    '/home': (context) => const HomeScreenPage(),
    "/home/addtask": (context) => const HomeScreenAddTaskPage(),
    "/home/edittask": (context) => const HomeScreenEditPage()
  };
}
