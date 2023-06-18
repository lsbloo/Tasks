import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  Future<FirebaseService> init() async {
    print("FirebaseCore initializeApp");
    await Firebase.initializeApp();
    return FirebaseService();
  }
}
