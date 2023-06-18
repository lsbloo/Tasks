import 'package:flutter/material.dart';
import 'package:task_login/contract/login_contract.dart';
import 'package:task_login/presenter/login_presenter.dart';
import 'package:tasks_core/core/state/base_state.dart';
import 'package:tasks_core/core/state/base_widget_view.dart';
import 'package:tasks_core/design-ui/color/colors_resource.dart';
import 'package:tasks_core/design-ui/images/Images_resouce.dart';

import '../components/login_appbar_component.dart';

class LoginScreenPage extends BaseWidgetView {
  const LoginScreenPage({Key? key}) : super(key: key);

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends BaseState<LoginScreenPage>
    implements LoginView {
  LoginPresenter? _loginPresenter;

  @override
  void onViewCreated() {
    _loginPresenter = LoginPresenterImpl(this);
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoginAppBarComponent(
                    onClosedClickListener: () {},
                    onTextClickListener: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width / 2),
                          child: Image.asset(
                            ImageResource.IMAGE_SPLASH_SCREEN,
                            width: 80,
                            height: 80,
                            alignment: Alignment.topLeft,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Padding(
                            padding: EdgeInsets.only(right: 44),
                            child: Text(
                              "Bem vindo ao App de Tarefas.",
                              style: TextStyle(
                                  color: Color(ColorResource.WHITE_BABY_SKY),
                                  fontSize: 16),
                            )),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                                foregroundColor:
                                    const Color(ColorResource.WHITE_BABY_SKY),
                                elevation: 10,
                                shape: const StadiumBorder(),
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width, 44)),
                            child: const Text("Criar Conta")),
                        const SizedBox(
                          height: 36,
                        ),
                        const Text(
                          "Mais opções",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(ColorResource.WHITE_BABY_SKY)),
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        const Text(
                          "Para acessar o código fonte do aplicativo acesse o link.",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(ColorResource.WHITE_BABY_SKY)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }

  @override
  popPage() {}

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
  showOrHideLoading(bool flag) {}
}