import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nomix/features/home_page/ui/page/home_page.dart';
import 'package:nomix/features/home_page/ui/state/home_page_bloc.dart';
import 'package:nomix/features/home_page/ui/widgets/splash_reveal_widget.dart';

class LoadingApp extends StatefulWidget {
  const LoadingApp({Key? key}) : super(key: key);

  @override
  State<LoadingApp> createState() => _LoadingAppState();
}

class _LoadingAppState extends State<LoadingApp> {
  final _revealController = SplashRevealController();

  @override
  void initState() {
    super.initState();
    context.read<HomePageBloc>().add(AuthGetDataEvent());
    _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 1));
    await _revealController.startReveal();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          SplashRevealWidget(
            controller: _revealController,
            duration: const Duration(milliseconds: 1500),
            onAnimationComplete: () {
              print('App reveal completed!');
            },
            child: MainPage(),
          ),
        ],
      ),
    );
  }
}
