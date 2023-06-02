import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasks_firebase/tasks_firebase.dart';
import 'package:tasks_flutter_one/firebase_options.dart';
import 'navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Calculator calculator  =  Calculator();

  print(calculator.addOne(10));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: RouterNavigation.ROUTERS,
      theme: ThemeData(
        fontFamily: 'Comic Sans'
      ),
    );
  }
}
