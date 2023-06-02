import 'package:tasks_flutter_one/core/router_navigation.dart';

abstract class BasePresenter<BaseView> {
  void init();

  void dispose();

  BaseView getView();
}
