import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tasks_core/core/state/base_state.dart';
import 'package:tasks_core/core/state/base_widget_view.dart';
import 'package:tasks_core/design-ui/color/colors_resource.dart';
import 'package:tasks_core/design-ui/components/custom_text_field.dart';

import '../components/login_app_bar_text_click_type.dart';
import '../components/login_appbar_component.dart';
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
              child: Consumer<LoginProvider>(
                builder: (context, loginProvider, child) {
                  _loginPresenter?.setProvider(loginProvider);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoginAppBarComponent(
                        onClosedClickListener: () {
                          _loginPresenter?.showMessageFeedBack(context, "Encerrando...");
                          _loginPresenter?.closeApp(context);

                          if(loginProvider.showFeedBackMessage != "") {
                            showMessage(loginProvider.showFeedBackMessage);
                          }
                        },
                        onTextClickListener: () {
                          popPage();
                        },
                        type: TypeClickLoginAppBar.LOGIN,
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Center(
                          child: Text(
                            "Criar Conta",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      CustomTaskTextField(
                        onTextChanged: (text) {},
                        hintText: "Digite seu email",
                        maxLengthInput: 30,
                        onMaxLengthInputExceed: () {},
                        textInputType: TextInputType.emailAddress,
                        suffixIcon: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      CustomTaskTextField(
                        onTextChanged: (text) {},
                        onMaxLengthInputExceed: () {},
                        maxLengthInput: 10,
                        isPassword: true,
                        hintText: "Digite sua senha",
                        textInputType: TextInputType.text,
                        suffixIcon: const Icon(
                          Icons.password,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 36),
                        child: Text("Lembrar E-mail?",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(
                                  ColorResource.WHITE_BABY_SKY,
                                ))),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 36, right: 36),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0))),
                                  backgroundColor:
                                      const MaterialStatePropertyAll<Color>(
                                          Colors.green),
                                ),
                                onPressed: () {},
                                child: true
                                    ? const Text("Registrar")
                                    : const CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        backgroundColor: Color(ColorResource
                                            .BLUE_COLOR_SPLASH_SCREEN),
                                      )),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
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
  showOrHideLoading(bool flag) {}

  @override
  void closeApp() {
    SystemNavigator.pop();
  }
}
