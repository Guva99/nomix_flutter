import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nomix/core/internal/sl.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/utils/get_it_utils.dart';
import 'package:nomix/features/app/bloc_providers.dart';
import 'package:nomix/features/app/routing/path_files.dart';
import 'package:telegram_web_app/telegram_web_app.dart' as tg;

final tgWebApp = tg.TelegramWebApp.instance;

Future<void> main() async {
  final initData = tgWebApp.initDataUnsafe;
  // можно сразу дернуть API бэка, передав initData
  GetItUtils.logger.w('АВТОРИЗАЦИЯ: ${initData?.authDate}');
  GetItUtils.logger.w('АВТОРИЗАЦИЯusername: ${initData?.chat?.username}');
  GetItUtils.logger.w('АВТОРИЗАЦИЯinitData: ${initData}');
   // try {
  //   if (TelegramWebApp.instance.isSupported) {
  //     TelegramWebApp.instance.ready();
  //     Future.delayed(const Duration(seconds: 1), TelegramWebApp.instance.expand);
  //   }
  // } catch (e) {
  //   print("Error happened in Flutter while loading Telegram $e");
  //   // add delay for 'Telegram seldom not loading' bug
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   main();
  //   return;
  // }

  FlutterError.onError = (details) {
    print("Flutter error happened: $details");
  };


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
