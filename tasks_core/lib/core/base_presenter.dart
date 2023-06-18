import 'package:tasks_core/base_provider.dart';

abstract class BasePresenter<BaseView> {
  void init();

  void dispose();

  BaseView getView();

  void setProvider(BaseProvider baseProvider);
}
