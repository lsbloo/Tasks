// Mocks generated by Mockito 5.4.1 from annotations
// in tasks_flutter_one/test/unit/auth/firebase_auth_test.dart.
// Do not manually edit this file.

// @dart=2.19

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tasks_firebase/auth/firebase_auth.dart' as _i3;
import 'package:tasks_firebase/firebase_vo/firebase_auth_vo.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeFirebaseAuthVO_0 extends _i1.SmartFake
    implements _i2.FirebaseAuthVO {
  _FakeFirebaseAuthVO_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FirebaseTaskAuth].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseTaskAuth extends _i1.Mock implements _i3.FirebaseTaskAuth {
  @override
  _i4.Future<_i2.FirebaseAuthVO> authenticateWithEmailAndPassword(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #authenticateWithEmailAndPassword,
          [
            email,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.FirebaseAuthVO>.value(_FakeFirebaseAuthVO_0(
          this,
          Invocation.method(
            #authenticateWithEmailAndPassword,
            [
              email,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.FirebaseAuthVO>.value(_FakeFirebaseAuthVO_0(
          this,
          Invocation.method(
            #authenticateWithEmailAndPassword,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.FirebaseAuthVO>);
  @override
  _i4.Future<_i2.FirebaseAuthVO> createUserWithEmailAndPassword(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createUserWithEmailAndPassword,
          [
            email,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.FirebaseAuthVO>.value(_FakeFirebaseAuthVO_0(
          this,
          Invocation.method(
            #createUserWithEmailAndPassword,
            [
              email,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.FirebaseAuthVO>.value(_FakeFirebaseAuthVO_0(
          this,
          Invocation.method(
            #createUserWithEmailAndPassword,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.FirebaseAuthVO>);
  @override
  void initialize() => super.noSuchMethod(
        Invocation.method(
          #initialize,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
