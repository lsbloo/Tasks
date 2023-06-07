library tasks_firebase;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks_firebase/auth/firebase_auth_const.dart';
import 'package:tasks_firebase/firebase_vo/firebase_auth_vo.dart';
import 'firebase_auth_service.dart';

class FirebaseTaskAuth implements FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<FirebaseAuthVO> authenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential firebaseAuth = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return Future<FirebaseAuthVO>.value(FirebaseAuthVO(
          true,
          FirebaseAuthConst.FIREBASE_AUTHENTICATE_SUCCESSFUL,
          firebaseAuth.credential?.accessToken,
          firebaseAuth.credential?.signInMethod));
    } catch (e) {
      return Future<FirebaseAuthVO>.value(FirebaseAuthVO(false,
          FirebaseAuthConst.FIREBASE_AUTHENTICATE_UNSUCCESSFUL, null, null));
    }
  }
}
