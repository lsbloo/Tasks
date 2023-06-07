import 'package:tasks_flutter_one/core/router_navigation.dart';

import '../contract/splash_contract.dart';

class SplashPresenterImpl extends Navigation implements SplashPresenter {
  final SplashView _view;
  static const _TIME_DEFAULT_SPLASH_SCREEN = 5;

  SplashPresenterImpl(this._view);

  @override
  void dispose() {}

  @override
  getView() => _view;

  @override
  void init() {
    _view.showMessage("Osvaldo Test");
    _setTimeAndNavigateToHomeScreen();
  }

  void _setTimeAndNavigateToHomeScreen() {
    Future.delayed(const Duration(seconds: _TIME_DEFAULT_SPLASH_SCREEN), () {
      _view.callNavigateHome();
    });
  }

  @override
  void navigateToHome(context) {
    navigateHome(context);
  }
}
