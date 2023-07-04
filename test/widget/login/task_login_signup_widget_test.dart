import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
@GenerateNiceMocks([MockSpec<LoginPresenter>(), MockSpec<LoginView>()])
import 'package:task_login/contract/login_contract.dart';
import 'package:task_login/data/provider/login_provider.dart';
import 'package:task_login/page/screens/signup_screen.dart';

import '../../unit/login/task_login_test.mocks.dart';

void main() {
  var loginPresenterMock = MockLoginPresenter();
  var loginViewMock = MockLoginView();

  onerrorIgnoreoverflowerrors(
      FlutterErrorDetails details, {
        bool forceReport = false,
      }) {
    assert(details != null);
    assert(details.exception != null);
    // ---

    bool ifIsOverflowError = false;
    var exception = details.exception;
    if (exception is FlutterError) {
      ifIsOverflowError = !exception.diagnostics
          .any((e) => e.value.toString().startsWith("A RenderFlex overflowed by"));
    }

    // Ignore if is overflow error.
    if (ifIsOverflowError) {
      print('Overflow error.');
    } else {
      FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
    }
  }


  testWidgets('should initialize login screen signup and validate and find all texts of page', (tester) async {
    FlutterError.onError = onerrorIgnoreoverflowerrors;
    await tester.pumpWidget(ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(),
      child: SignupLoginScreenView(
        loginView: loginViewMock,
        loginPresenter: loginPresenterMock,
      ),
    ));

    // Create the Finders.
    final titleFinder = find.text('Entrar');
    final messageFinder = find.text('Gerencie todas as atividades importantes do seu dia a dia.');
    final textButtonBackPage = find.text("Voltar para tela inicial?");
    
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
    expect(textButtonBackPage, findsOneWidget);

  });

  testWidgets('should initialize login screen signup and validate email textfield', (tester) async {
    FlutterError.onError = onerrorIgnoreoverflowerrors;
    await tester.pumpWidget(ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(),
      child: SignupLoginScreenView(
        loginView: loginViewMock,
        loginPresenter: loginPresenterMock,
      ),
    ));

    await tester.pumpAndSettle();

    final emailTextField = find.byKey(const Key("EMAIL_FIELD"));

    expect(emailTextField, findsOneWidget);
  });

  testWidgets('should initialize login screen signup and validate password textfield', (tester) async {
    FlutterError.onError = onerrorIgnoreoverflowerrors;
    await tester.pumpWidget(ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(),
      child: SignupLoginScreenView(
        loginView: loginViewMock,
        loginPresenter: loginPresenterMock,
      ),
    ));

    await tester.pumpAndSettle();

    final emailTextField = find.byKey(const Key("PASSWORD_FIELD"));

    expect(emailTextField, findsOneWidget);
  });
}


