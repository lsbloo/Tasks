import 'package:injectable/injectable.dart';
import 'package:tasks_firebase/auth/firebase_auth.dart';
import 'package:tasks_firebase/auth/firebase_auth_service.dart';

import 'firebase_service.dart';

@module
abstract class AppModule {
  @injectable
  FirebaseService get firebaseService => FirebaseService();

  @injectable
  FirebaseAuthService get firebaseAuthService => FirebaseTaskAuth();
}
