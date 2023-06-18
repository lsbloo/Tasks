import 'package:tasks_core/base_provider.dart';
import 'package:tasks_core/navigation/router_navigation.dart';
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
    _setTimeAndNavigateToLoginScreen();
  }

  void _setTimeAndNavigateToLoginScreen() {
    Future.delayed(const Duration(seconds: _TIME_DEFAULT_SPLASH_SCREEN), () {
      _view.callNavigateToLogin();
    });
  }

  @override
  void navigateToHome(context) {
    navigateHome(context);
  }

  @override
  void navigateToLogin(context) {
    navigateLogin(context);
  }

  @override
  void setProvider(BaseProvider baseProvider) {}
}
