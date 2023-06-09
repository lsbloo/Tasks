import 'package:injectable/injectable.dart';
import 'package:task_login/contract/login_contract.dart';
import 'package:task_login/presenter/login_presenter.dart';
import 'package:tasks_firebase/auth/firebase_auth_service.dart';
import 'package:tasks_flutter_one/injection.dart';

@module
abstract class LoginModule {
  @injectable
  LoginPresenterInst get loginPresenter => LoginPresenterInst();
}

class LoginPresenterInst {
  LoginPresenter newInstance(
    LoginView view,
  ) {
    return LoginPresenterImpl(
        view, getIt<FirebaseAuthService>());
  }
}
