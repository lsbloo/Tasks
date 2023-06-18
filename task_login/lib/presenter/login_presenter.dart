import 'package:task_login/contract/login_contract.dart';
import 'package:tasks_core/navigation/router_navigation.dart';
import 'package:tasks_firebase/auth/firebase_auth_service.dart';

import '../data/provider/login_provider.dart';


class LoginPresenterImpl extends Navigation implements LoginPresenter {

  final FirebaseAuthService _firebaseAuthService;
  final LoginProvider _loginProvider;
  final LoginView _view;

  LoginPresenterImpl(this._view, this._firebaseAuthService, this._loginProvider);


  @override
  void dispose() {

  }

  @override
  getView() => _view;

  @override
  void init() {
    _firebaseAuthService.initialize();
  }
}
