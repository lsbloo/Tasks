
import 'package:tasks_flutter_one/core/base_presenter.dart';
import 'package:tasks_flutter_one/core/base_view.dart';

abstract class SplashPresenter extends BasePresenter {
  void navigateToHome(context);
}

abstract class SplashView extends BaseView {
  @override
  void showMessage(String message);
  void callNavigateHome();
}