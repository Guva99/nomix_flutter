part of 'path_files.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'SmartFlat');

class RoutesInit {
  final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePath.initPagePath,
    redirect: (context, state) {
      final uriStr = state.uri.toString();
      final fullUri = Uri.base;
      final mode = fullUri.queryParameters['mode'];
      GetItUtils.logger.w('Полный URI: $fullUri');

      if (uriStr.contains('tgWebAppData=')) {
        GetItUtils.logger.w('mode: $mode');
        // нашли
        return RoutePath.initPagePath;
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: RoutePath.initPagePath,
        name: RoutePath.initPagePath,
        builder: (context, state) {
          return LoadingApp();
        },
      ),
      GoRoute(
        path: RoutePath.mainPage,
        name: RoutePath.mainPage,
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: RoutePath.approveReceipts,
        name: RoutePath.approveReceipts,
        builder: (context, state) => ApproveReceiptsPage(),
      ),
      GoRoute(
        path: RoutePath.detailPageStatisticPath,
        name: RoutePath.detailPageStatisticPath,
        builder: (context, state) => DetailStatisticPage(),
      ),
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
