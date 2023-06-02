import 'package:flutter/material.dart';
import 'package:tasks_flutter_one/core/state/base_state.dart';
import 'package:tasks_flutter_one/core/state/base_widget_view.dart';
import 'package:tasks_flutter_one/design-ui/color/colors_resource.dart';
import '../../../design-ui/images/Images_resouce.dart';
import '../contract/splash_contract.dart';
import '../presenter/splash_presenter.dart';


class SplashScreenPage extends BaseWidgetView {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<BaseWidgetView> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends BaseState<SplashScreenPage>
    implements SplashView {
  SplashPresenter? _presenter;
  String _messsage = "";
  late Image imageSplash;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color(ColorResource.BLUE_COLOR_SPLASH_SCREEN),
      child: Center(
          child: Image.asset(
        ImageResource.IMAGE_SPLASH_SCREEN,
        width: 150,
        height: 150,
        alignment: Alignment.center,
      )),
    ));
  }

  @override
  void onViewCreated() {
    _presenter = SplashPresenterImpl(this);
    _presenter?.init();
    imageSplash = Image.asset(
      ImageResource.IMAGE_SPLASH_SCREEN,
      width: 150,
      height: 150,
      alignment: Alignment.center,
    );
    super.onViewCreated();
  }

  @override
  void onResume() {
    precacheImage(imageSplash.image, context);
    super.onResume();
  }

  @override
  void showMessage(String message) {
    setState(() {
      _messsage = message;
    });
  }

  @override
  void callNavigateHome() {
    _presenter?.navigateToHome(context);
  }

  @override
  showError(String message) {}

  @override
  showOrHideLoading(bool flag) {

  }

  @override
  popPage() {

  }
}
