import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nomix/core/internal/sl.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/utils/get_it_utils.dart';
import 'package:nomix/features/app/bloc_providers.dart';
import 'package:nomix/features/app/routing/path_files.dart';

Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = RoutesInit();
  final GetIt locator = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: buildListProviders(locator: locator),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: Themes.lightTheme,
        routerConfig: _router.router,
      ),
    );
  }
}
