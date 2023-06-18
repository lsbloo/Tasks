import 'dart:ffi';

import 'package:task_login/contract/login_contract.dart';
import 'package:tasks_core/base_provider.dart';
import 'package:tasks_core/navigation/router_navigation.dart';
import 'package:tasks_firebase/auth/firebase_auth_service.dart';
import 'package:provider/provider.dart';
import '../data/provider/login_provider.dart';

class LoginPresenterImpl extends Navigation implements LoginPresenter {
  static const int _TIME_CLOSE_APP_MESSAGE = 1;
  FirebaseAuthService _firebaseAuthService;
  LoginProvider? _loginProvider;
  final LoginView _view;

  LoginPresenterImpl(this._view, this._firebaseAuthService);

  @override
  void dispose() {}

  @override
  getView() => _view;

  @override
  void init() {
    _firebaseAuthService.initialize();
  }

  @override
  void navigateToCreateAccountPage(context) {
    navigateCreateAccount(context);
  }

  @override
  void closeApp(context) {
    Future.delayed(const Duration(seconds: _TIME_CLOSE_APP_MESSAGE),
        () => {_view.closeApp()});
  }

  @override
  void navigateToLoginSignInPage(context) {}

  @override
  void setProvider(BaseProvider baseProvider) {
    _loginProvider = baseProvider as LoginProvider?;
  }

  @override
  void showMessageFeedBack(context, String message) {
    Provider.of<LoginProvider>(context, listen: false)
        .onShowFeedBackMessage(message);
  }
}
