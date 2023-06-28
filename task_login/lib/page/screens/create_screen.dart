import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_core/core/state/base_state.dart';
import 'package:tasks_core/core/state/base_widget_view.dart';
import 'package:tasks_core/design-ui/color/colors_resource.dart';
import 'package:tasks_core/design-ui/components/custom_text_field.dart';

import '../../components/login_app_bar_text_click_type.dart';
import '../../components/login_appbar_component.dart';
import '../../contract/login_contract.dart';
import '../../data/provider/login_provider.dart';

class CreateLoginScreenView extends BaseWidgetView {
  final LoginPresenter loginPresenter;
  final LoginView loginView;
  final TextEditingController textEmailEditingController;
  final TextEditingController textPasswordEditingController;

  const CreateLoginScreenView(
      {Key? key,
      required this.loginPresenter,
      required this.loginView,
      required this.textEmailEditingController,
      required this.textPasswordEditingController})
      : super(key: key);

  @override
  State<CreateLoginScreenView> createState() => _CreateLoginScreenViewState();
}

class _CreateLoginScreenViewState extends BaseState<CreateLoginScreenView> {
  @override
  int get milliSecondsDurationAnimationPageTransition => 600;

  bool _rememberEmail = false;

  void _onRememberEmailChanged(bool newValue) => setState(() {
        _rememberEmail = newValue;
      });

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
                onTextChanged: (text) {
                  widget.textEmailEditingController.text = text;
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
                onTextChanged: (text) {
                  widget.textPasswordEditingController.text = text;
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
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Checkbox(
                        value: _rememberEmail,
                        onChanged: (value) {
                          _onRememberEmailChanged(value!);
                        }),
                    const Text("Lembrar E-mail?",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(
                              ColorResource.WHITE_BABY_SKY,
                            ))),
                  ],
                ),
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0))),
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Colors.green),
                        ),
                        onPressed: () {
                          widget.loginPresenter.registerAccount(
                              widget.textEmailEditingController.text,
                              widget.textPasswordEditingController.text,
                              _rememberEmail);
                        },
                        child: true
                            ? const Text("Registrar")
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
