import 'package:flutter/material.dart';
 import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/features/app/routing/path_files.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
   runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = RoutesInit();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: Themes.lightTheme,
      routerConfig: _router.router,
    );
  }
}
