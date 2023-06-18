import 'package:tasks_core/core/base_presenter.dart';
import 'package:tasks_core/core/base_view.dart';

abstract class LoginPresenter extends BasePresenter {
  void navigateToCreateAccountPage(context);
  void closeApp(context);
  void navigateToLoginSignInPage(context);
  void showMessageFeedBack(context,String message);
}

abstract class LoginView extends BaseView {
  void closeApp();
}
