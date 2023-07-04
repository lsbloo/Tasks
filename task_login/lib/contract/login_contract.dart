import 'package:tasks_core/core/base_presenter.dart';
import 'package:tasks_core/core/base_view.dart';

abstract class LoginPresenter extends BasePresenter {
  void navigateToCreateAccountPage(context);
  void navigateToLoginSignUp(context);
  void navigateToHomePage(context);
  void closeApp(context);
  void navigateToLoginSignInPage(context);
  void showMessageFeedBack(context,String message);
  void registerAccount(String email, String password, bool rememberEmail);
  void signUpAccount(String email, String password);
}

abstract class LoginView extends BaseView {
  void closeApp();
  void clearInputs();
  void navigateToHome();
}
