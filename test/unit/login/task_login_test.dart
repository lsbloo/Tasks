import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
@GenerateNiceMocks([MockSpec<LoginPresenter>(), MockSpec<LoginView>()])
import 'package:task_login/contract/login_contract.dart';
@GenerateNiceMocks([MockSpec<FirebaseTaskAuth>()])
import 'package:tasks_firebase/auth/firebase_auth.dart';
import 'package:tasks_firebase/auth/firebase_auth_const.dart';
import 'package:tasks_firebase/firebase_vo/firebase_auth_vo.dart';

import 'task_login_test.mocks.dart';

void main() {
  var loginPresenterMock = MockLoginPresenter();
  var loginViewMock = MockLoginView();
  var loginFirebaseAuthMock = MockFirebaseTaskAuth();

  test('should call init login presenter and initialize firebaseAuthService',
      () {
    when(loginPresenterMock.init()).thenAnswer((_) {
      loginFirebaseAuthMock.initialize();
      verify(loginFirebaseAuthMock.initialize());
    });
  });

  test('should call register account and show loading page', () {
    // GIVEN
    var email = "email@teste.com.br";
    var password = "1237432";

    // WHEN
    when(loginPresenterMock.registerAccount(email, password, false))
        .thenAnswer((_) {
      loginViewMock.showOrHideLoading(true);
    });
    loginPresenterMock.registerAccount(email, password, false);

    // THEN
    verify(loginViewMock.showOrHideLoading(true));
  });

  test(
      'should call register account and if email and password isEmpty call showMessageView',
      () {
    // GIVEN
    var email = "";
    var password = "";

    // WHEN
    when(loginPresenterMock.registerAccount(email, password, false))
        .thenAnswer((_) {
      loginViewMock.showMessage("Digite os campos corretamente");
    });
    loginPresenterMock.registerAccount(email, password, false);

    // THEN
    verify(loginViewMock.showMessage("Digite os campos corretamente"));
  });

  test(
      'should call register account and if email and password is valid call createUser firebaseAuth',
      () {
    // GIVEN
    var email = "osvaldo.filho@al.ifnet.edu.br";
    var password = "400282944";

    // WHEN
    when(loginPresenterMock.registerAccount(email, password, false))
        .thenAnswer((_) {
      loginFirebaseAuthMock.createUserWithEmailAndPassword(email, password);
    });

    loginPresenterMock.registerAccount(email, password, false);

    // THEN
    verify(
        loginFirebaseAuthMock.createUserWithEmailAndPassword(email, password));
  });

  test(
      'should call register account and if email and password is valid call createUser firebaseAuth and has successful create user',
      () {
    // GIVEN
    var email = "osvaldo.filho@al.ifnet.edu.br";
    var password = "400282944";

    // WHEN
    when(loginFirebaseAuthMock.createUserWithEmailAndPassword(email, password))
        .thenAnswer((_) => Future<FirebaseAuthVO>.value(FirebaseAuthVO(true,
            FirebaseAuthConst.FIREBASE_CREATE_USER_SUCCESSFUL, null, null)));

    when(loginPresenterMock.registerAccount(email, password, false))
        .thenAnswer((_) {
      loginViewMock.showOrHideLoading(false);
      loginViewMock.showMessage("Conta criada com sucesso");
    });

    // THEN
    loginFirebaseAuthMock
        .createUserWithEmailAndPassword(email, password)
        .then((value) => {
              expect(true, value.hasAuthenticateSuccessful),
              expect(FirebaseAuthConst.FIREBASE_CREATE_USER_SUCCESSFUL,
                  value.message)
            });

    loginPresenterMock.registerAccount(email, password, false);

    verifyInOrder([
      loginFirebaseAuthMock.createUserWithEmailAndPassword(email, password),
      loginViewMock.showOrHideLoading(false),
      loginViewMock.showMessage("Conta criada com sucesso")
    ]);
  });

  test(
      'should call register account and if email and password is not valid call createUser firebaseAuth and has unsuccessful create user',
      () {
    // GIVEN
    var email = "osvaldo.filho@al.ifnet.edu.br";
    var password = "";

    // WHEN
    when(loginFirebaseAuthMock.createUserWithEmailAndPassword(email, password))
        .thenAnswer((_) => Future<FirebaseAuthVO>.value(FirebaseAuthVO(false,
            FirebaseAuthConst.FIREBASE_CREATE_USER_UNSUCCESSFUL, null, null)));

    when(loginPresenterMock.registerAccount(email, password, false))
        .thenAnswer((_) {
      loginViewMock.showOrHideLoading(false);
      loginViewMock
          .showMessage("Não foi possivel criar sua conta, tente novamente!");
    });

    // THEN
    loginFirebaseAuthMock
        .createUserWithEmailAndPassword(email, password)
        .then((value) => {
              expect(false, value.hasAuthenticateSuccessful),
              expect(FirebaseAuthConst.FIREBASE_CREATE_USER_UNSUCCESSFUL,
                  value.message)
            });

    loginPresenterMock.registerAccount(email, password, false);

    verifyInOrder([
      loginFirebaseAuthMock.createUserWithEmailAndPassword(email, password),
      loginViewMock.showOrHideLoading(false),
      loginViewMock
          .showMessage("Não foi possivel criar sua conta, tente novamente!")
    ]);
  });

  test("should call authenticate method firebase when user send valid data",
      () {
    // GIVEN
    var email = "osvaldo.filho@al.ifnet.edu.br";
    var password = "123456";

    // WHEN
    when(loginFirebaseAuthMock.authenticateWithEmailAndPassword(
            email, password))
        .thenAnswer((_) => Future<FirebaseAuthVO>.value(FirebaseAuthVO(true,
            FirebaseAuthConst.FIREBASE_AUTHENTICATE_SUCCESSFUL, null, null)));

    when(loginPresenterMock.signUpAccount(email, password)).thenAnswer((_) {
      loginViewMock.showOrHideLoading(false);
      loginViewMock.showMessage("Login Realizado com sucesso");
    });

    // THEN
    loginFirebaseAuthMock
        .authenticateWithEmailAndPassword(email, password)
        .then((value) => {
              expect(true, value.hasAuthenticateSuccessful),
              expect(FirebaseAuthConst.FIREBASE_AUTHENTICATE_SUCCESSFUL,
                  value.message)
            });

    loginPresenterMock.signUpAccount(email, password);

    verifyInOrder([
      loginFirebaseAuthMock.authenticateWithEmailAndPassword(email, password),
      loginViewMock.showOrHideLoading(false),
      loginViewMock.showMessage("Login Realizado com sucesso")
    ]);
  });

  test(
      "should not call authenticate method firebase when user send invalid data",
      () {
    // GIVEN
    var email = "osvaldo.filho@al.ifnet.edu.br";
    var password = "";

    // WHEN
    when(loginFirebaseAuthMock.authenticateWithEmailAndPassword(
            email, password))
        .thenAnswer((_) => Future<FirebaseAuthVO>.value(FirebaseAuthVO(false,
            FirebaseAuthConst.FIREBASE_AUTHENTICATE_UNSUCCESSFUL, null, null)));

    when(loginPresenterMock.signUpAccount(email, password)).thenAnswer((_) {
      loginViewMock.showMessage("Digite os campos corretamente");
    });

    // THEN
    loginFirebaseAuthMock
        .authenticateWithEmailAndPassword(email, password)
        .then((value) => {
              expect(false, value.hasAuthenticateSuccessful),
              expect(FirebaseAuthConst.FIREBASE_AUTHENTICATE_UNSUCCESSFUL,
                  value.message)
            });

    loginPresenterMock.signUpAccount(email, password);

    verifyInOrder([loginViewMock.showMessage("Digite os campos corretamente")]);
  });
}
