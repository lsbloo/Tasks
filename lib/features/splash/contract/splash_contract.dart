import 'package:tasks_core/core/base_presenter.dart';
import 'package:tasks_core/core/base_view.dart';

abstract class SplashPresenter extends BasePresenter {
  void navigateToHome(context);

  void navigateToLogin(context);
}

abstract class SplashView extends BaseView {
  @override
  void showMessage(String message);

  void callNavigateHome();

  void callNavigateToLogin();
}
