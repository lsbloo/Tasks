import 'package:flutter/material.dart';
import 'package:tasks_core/core/state/base_state.dart';
import 'package:tasks_core/core/state/base_widget_view.dart';
import 'package:provider/provider.dart';
import 'package:tasks_core/design-ui/components/custom_text_field.dart';

import '../../components/login_app_bar_text_click_type.dart';
import '../../components/login_appbar_component.dart';
import '../../contract/login_contract.dart';
import '../../data/provider/login_provider.dart';
import 'package:tasks_core/design-ui/color/colors_resource.dart';

class SignupLoginScreenView extends BaseWidgetView {
  final LoginPresenter loginPresenter;
  final LoginView loginView;

  const SignupLoginScreenView({
    Key? key,
    required this.loginPresenter,
    required this.loginView,
  }) : super(key: key);

  @override
  BaseState<SignupLoginScreenView> createState() =>
      _SignupLoginScreenViewState();
}

class _SignupLoginScreenViewState extends BaseState<SignupLoginScreenView> {
  late final TextEditingController textEmailEditingController;
  late final TextEditingController textPasswordEditingController;

  @override
  int get milliSecondsDurationAnimationPageTransition => 500;


  @override
  void onViewCreated() {
    textEmailEditingController = TextEditingController();
    textPasswordEditingController = TextEditingController();
    super.onViewCreated();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: Consumer<LoginProvider>(
        builder: (context, loginProvider, child) {
          widget.loginPresenter.setProvider(loginProvider);

          if (loginProvider.showLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                backgroundColor: Color(ColorResource.BLUE_COLOR_SPLASH_SCREEN),
              ),
            );
          }

          if (loginProvider.showLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                backgroundColor: Color(ColorResource.BLUE_COLOR_SPLASH_SCREEN),
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginAppBarComponent(
                onClosedClickListener: () {
                  widget.loginPresenter
                      .showMessageFeedBack(context, "Encerrando...");
                  widget.loginPresenter.closeApp(context);

                  if (loginProvider.showFeedBackMessage != "") {
                    widget.loginView
                        .showMessage(loginProvider.showFeedBackMessage);
                  }
                },
                onTextClickListener: () {
                  widget.loginView.popPage();
                },
                type: TypeClickLoginAppBar.LOGIN,
              ),
              const SizedBox(
                height: 36,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 36, right: 16),
                child: Text(
                  "Entrar",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 36),
                child: Text(
                  "Gerencie todas as atividades importantes do seu dia a dia.",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              CustomTaskTextField(
                key: const Key("EMAIL_FIELD"),
                onTextChanged: (text) {
                  textEmailEditingController.text = text;
                },
                hintText: "Digite seu e-mail",
                maxLengthInput: 30,
                onMaxLengthInputExceed: () {
                  widget.loginView.showMessage("Tamanho do e-mail excedido");
                },
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
                key: Key("PASSWORD_FIELD"),
                onTextChanged: (text) {
                  textPasswordEditingController.text = text;
                },
                onMaxLengthInputExceed: () {
                  widget.loginView.showMessage("Tamanho da senha excedida");
                },
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
                height: 2,
              ),
              const SizedBox(
                height: 36,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28, right: 28),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0))),
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Colors.blueAccent),
                        ),
                        onPressed: () {
                          widget.loginPresenter.signUpAccount(
                              textEmailEditingController.text,
                              textPasswordEditingController.text);
                        },
                        child: true
                            ? const Text("Entrar")
                            : const CircularProgressIndicator(
                                strokeWidth: 2.0,
                                backgroundColor: Color(
                                    ColorResource.BLUE_COLOR_SPLASH_SCREEN),
                              )),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
