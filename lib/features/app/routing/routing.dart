part of 'path_files.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'SmartFlat');

class RoutesInit {
  final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePath.initPagePath,
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
        ]

      ),

      // GoRoute(
      //   path: RoutePath.debugMenuPath,
      //   name: RoutePath.debugMenuPath,
      //   builder: (context, state) => DebugMenu(backRoutePath: state.extra.toString()),
      // ),
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
