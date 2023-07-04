import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_login/page/screens/signup_screen.dart';
import 'package:tasks_core/core/state/base_state.dart';
import 'package:tasks_core/core/state/base_widget_view.dart';

import '../contract/login_contract.dart';
import '../data/di/login_module.dart';
import '../data/provider/login_provider.dart';
import '../injection_login.dart';
import 'package:provider/provider.dart';
import 'package:tasks_core/design-ui/color/colors_resource.dart';

class LoginSignUpScreenPage extends BaseWidgetView {
  const LoginSignUpScreenPage({Key? key}) : super(key: key);

  @override
  BaseState<LoginSignUpScreenPage> createState() =>
      _LoginSignUpScreenPageState();
}

class _LoginSignUpScreenPageState extends BaseState<LoginSignUpScreenPage>
    implements LoginView {
  LoginPresenter? _loginPresenter;

  @override
  void onViewCreated() {
    _loginPresenter = getIt<LoginPresenterInst>().newInstance(this);
    _loginPresenter?.init();
    super.onViewCreated();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: const Color(ColorResource.BLUE_COLOR_STEEL),
          body: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: SafeArea(
              left: true,
              right: true,
              top: true,
              bottom: true,
              child: SignupLoginScreenView(
                loginPresenter: _loginPresenter!,
                loginView: this,
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return true;
        });
  }

  @override
  void clearInputs() {}

  @override
  void closeApp() {
    SystemNavigator.pop();
  }

  @override
  popPage() {
    Navigator.pop(context);
  }

  @override
  showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  showOrHideLoading(bool flag) {
    Provider.of<LoginProvider>(context, listen: false).onShowLoadingPage(flag);
  }

  @override
  void navigateToHome() {
    _loginPresenter?.navigateToHomePage(context);
  }
}
