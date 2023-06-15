import 'package:task_login/contract/login_contract.dart';
import 'package:tasks_core/navigation/router_navigation.dart';


class LoginPresenterImpl extends Navigation implements LoginPresenter {

  LoginView _view;

  LoginPresenterImpl(this._view);


  @override
  void dispose() {

  }

  @override
  getView() => _view;

  @override
  void init() {

  }
}
