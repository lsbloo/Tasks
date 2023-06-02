import '../features/home/page/home_screen_add_task_page.dart';
import '../features/home/page/home_screen_page.dart';
import '../features/splash/page/splash_screen_page.dart';

class RouterNavigation {
  static const SPLASH_SCREEN = '/';
  static const HOME_SCREEN = '/home';
  static const HOME_ADD_TASK_SCREEN = '/home/addtask';

  static final ROUTERS = {
    '/': (context) => const SplashScreenPage(),
    '/home': (context) => const HomeScreenPage(),
    "/home/addtask": (context) => const HomeScreenAddTaskPage()
  };
}
