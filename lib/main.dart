import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_core/navigation/app_router.dart';
import 'package:tasks_flutter_one/features/home/data/provider/home_task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
      create: (context) => HomeTaskProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: RouterNavigation.ROUTERS,
      theme: ThemeData(fontFamily: 'Comic Sans'),
    );
  }
}
