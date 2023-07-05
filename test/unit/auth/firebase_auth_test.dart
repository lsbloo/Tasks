import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
@GenerateNiceMocks([MockSpec<FirebaseTaskAuth>()])
import 'package:tasks_firebase/auth/firebase_auth.dart';
import 'package:tasks_firebase/auth/firebase_auth_const.dart';
import 'package:tasks_firebase/firebase_vo/firebase_auth_vo.dart';

import 'firebase_auth_test.mocks.dart';

void main() {
  test(
      'should returned autenticate false when autenticateWithEmailAndPassword have incorrect email',
      () {
    var test = MockFirebaseTaskAuth();

    when(test.authenticateWithEmailAndPassword("osvaldo", "21313")).thenAnswer(
        (_) => Future<FirebaseAuthVO>.value(
            FirebaseAuthVO(false, "User not autenticate", null, null)));

    test
        .authenticateWithEmailAndPassword("osvaldo", "21313")
        .then((value) => {expect(false, value.hasAuthenticateSuccessful)});
  });

  test(
      'should returned create user true when createUserWithEmailAndPassword has successful called',
      () {
    var mockFirebaseAuth = MockFirebaseTaskAuth();

    when(mockFirebaseAuth.createUserWithEmailAndPassword(
            "osvaldo.filho@al.infnet.edu.br", "40028922"))
        .thenAnswer((_) => Future<FirebaseAuthVO>.value(FirebaseAuthVO(true,
            FirebaseAuthConst.FIREBASE_CREATE_USER_SUCCESSFUL, null, null)));

    mockFirebaseAuth
        .createUserWithEmailAndPassword(
            "osvaldo.filho@al.infnet.edu.br", "40028922")
        .then((value) => {
              expect(true, value.hasAuthenticateSuccessful),
              expect(FirebaseAuthConst.FIREBASE_CREATE_USER_SUCCESSFUL,
                  value.message)
            });
  });

  test(
      'should returned create user false when createUserWithEmailAndPassword has unsuccessful called',
      () {
    var mockFirebaseAuth = MockFirebaseTaskAuth();

    when(mockFirebaseAuth.createUserWithEmailAndPassword(
            "osvaldo.filho@al.infnet.edu.br", "12"))
        .thenAnswer((_) => Future<FirebaseAuthVO>.value(FirebaseAuthVO(false,
            FirebaseAuthConst.FIREBASE_CREATE_USER_UNSUCCESSFUL, null, null)));

    mockFirebaseAuth
        .createUserWithEmailAndPassword("osvaldo.filho@al.infnet.edu.br", "12")
        .then((value) => {
              expect(false, value.hasAuthenticateSuccessful),
              expect(FirebaseAuthConst.FIREBASE_CREATE_USER_UNSUCCESSFUL,
                  value.message)
            });
  });

  test(
      'should returned authenticate user true when authenticateWithEmailAndPassword has successful called',
      () {
    var mockFirebaseAuth = MockFirebaseTaskAuth();

    when(mockFirebaseAuth.authenticateWithEmailAndPassword(
            "osvaldo.filho@al.infnet.edu.br", "12412414"))
        .thenAnswer((_) => Future<FirebaseAuthVO>.value(FirebaseAuthVO(true,
            FirebaseAuthConst.FIREBASE_AUTHENTICATE_SUCCESSFUL, null, null)));

    mockFirebaseAuth
        .authenticateWithEmailAndPassword(
            "osvaldo.filho@al.infnet.edu.br", "12412414")
        .then((value) => {
              expect(true, value.hasAuthenticateSuccessful),
              expect(FirebaseAuthConst.FIREBASE_AUTHENTICATE_SUCCESSFUL,
                  value.message)
            });
  });
}
