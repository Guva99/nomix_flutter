part of 'path_files.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'SmartFlat');

class RoutesInit {
  final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: RoutePath.initPagePath,
    redirect: (context, state) {
      GetItUtils.logger.w('REDRIRCT: ${state.uri.queryParameters}');
      GetItUtils.logger.w('state.ur: ${state.uri}');
      final uriStr = state.uri.toString();
      if (uriStr.contains('tgWebAppData=')) {
        // нашли
        return RoutePath.initPagePath;
      }
      return null;
    },
    routes: <RouteBase>[

      GoRoute(
          path: RoutePath.initPagePath,
          name: RoutePath.initPagePath,
          builder: (context, state) => const MainPage(),
          routes: [
            GoRoute(
              path: RoutePath.detailPageStatisticPath,
              name: RoutePath.detailPageStatisticPath,
              builder: (context, state) => const DetailStatisticPage(),
            ),
          ]),
      GoRoute(
        path: RoutePath.debugMenuPath,
        name: RoutePath.debugMenuPath,
        builder: (context, state) => DebugMenu(backRoutePath: state.extra.toString()),
      ),
      GoRoute(
        path: '*',
        builder: (context, state) => Scaffold(
          body: Center(
            child: Text('ERROROROR: ${state.fullPath} // $state'),
          ),
        ),
      ),
    ],
  );
}

Page noTransitionPage(Widget child) {
  return NoTransitionPage(child: child);
}

class InviteFriendsPage extends StatelessWidget {
  const InviteFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
