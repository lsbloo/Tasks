import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_login/page/screens/create_screen.dart';
import 'package:tasks_core/core/state/base_state.dart';
import 'package:tasks_core/core/state/base_widget_view.dart';
import 'package:tasks_core/design-ui/color/colors_resource.dart';
import 'package:provider/provider.dart';
import '../contract/login_contract.dart';
import '../data/di/login_module.dart';
import '../data/provider/login_provider.dart';
import '../injection_login.dart';

class LoginCreateScreenPage extends BaseWidgetView {
  const LoginCreateScreenPage({Key? key}) : super(key: key);

  @override
  State<LoginCreateScreenPage> createState() => _LoginCreateScreenPageState();
}

class _LoginCreateScreenPageState extends BaseState<LoginCreateScreenPage>
    implements LoginView {
  LoginPresenter? _loginPresenter;
  final TextEditingController _textEmailEditingController =
      TextEditingController();
  final TextEditingController _textPasswordEditingController =
      TextEditingController();

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
              child: CreateLoginScreenView(
                  loginPresenter: _loginPresenter!,
                  loginView: this,
                  textEmailEditingController: _textEmailEditingController,
                  textPasswordEditingController:
                      _textPasswordEditingController),
            ),
          ),
        ),
        onWillPop: () async {
          return true;
        });
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
  void closeApp() {
    SystemNavigator.pop();
  }

  @override
  void clearInputs() {
    setState(() {
      _textPasswordEditingController.text = "";
      _textEmailEditingController.text = "";
    });
  }
}
