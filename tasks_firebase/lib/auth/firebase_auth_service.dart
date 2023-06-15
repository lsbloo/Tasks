import 'package:tasks_firebase/firebase_vo/firebase_auth_vo.dart';

abstract class FirebaseAuthService {
  Future<FirebaseAuthVO> authenticateWithEmailAndPassword(
      String email, String password);

  Future<FirebaseAuthVO> createUserWithEmailAndPassword(
      String email, String password);
}
