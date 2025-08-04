import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nomix/core/internal/sl.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/utils/get_it_utils.dart';
import 'package:nomix/features/app/bloc_providers.dart';
import 'package:nomix/features/app/routing/path_files.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:telegram_web_app/telegram_web_app.dart';
// if (Platform.isIos || Platform.isAndroid) 'package:telegram_web_app/telegram_web_app.dart'

late SharedPreferences prefs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  try {
    if (TelegramWebApp.instance.isSupported) {
      final webApp = TelegramWebApp.instance;

      webApp.ready();
      webApp.disableVerticalSwipes();
      webApp.expand();
    }
  } catch (e) {
    print("Error happened in Flutter while loading Telegram $e");
    // add delay for 'Telegram seldom not loading' bug
    await Future.delayed(const Duration(milliseconds: 200));
    main();
    return;
  }

  FlutterError.onError = (details) {
    print("Flutter error happened: $details");
  };
  FlutterError.onError = (details) {
    print("Flutter error happened: $details");
  };

  final talker = TalkerFlutter.init(
    settings: TalkerSettings(
      colors: {
        // TalkerLogType.verbose: AnsiPen()..yellow(),
      },
    ),
  );
  getIt.registerSingleton<Talker>(talker);

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
  void initState() {
    super.initState();
  }

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
