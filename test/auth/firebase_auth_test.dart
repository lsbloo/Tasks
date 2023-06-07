import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
@GenerateNiceMocks([MockSpec<FirebaseTaskAuth>()])
import 'package:tasks_firebase/auth/firebase_auth.dart';
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
}
