part of 'path_files.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'SmartFlat');

class RoutesInit {
  final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePath.initPagePath,
    redirect: (context, state) {
      GetItUtils.logger.w('REDRIRCT: ${state.uri.queryParameters}');
      GetItUtils.logger.w('state.ur: ${state.uri}');
      try {
        tryParseTelegramInit(state);
      } catch (e) {
        GetItUtils.logger.w('ERRORO ${e}');
      }
      final uriStr = state.uri.toString();
      if (uriStr.contains('tgWebAppData=')) {
        GetItUtils.logger.w('containsur: ${state.uri}');

        // нашли
        return RoutePath.initPagePath;
      }
      return null;

    },
    routes: <RouteBase>[
      GoRoute(
        path: RoutePath.initPagePath,
        name: RoutePath.initPagePath,
        builder: (context, state) => LoadingApp(),
      ),
      GoRoute(
        path: RoutePath.mainPage,
        name: RoutePath.mainPage,
        builder: (context, state) => const MainPage(),
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

class InviteFriendsPage extends StatelessWidget {
  const InviteFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

tryParseTelegramInit(GoRouterState state) {
  final uriStr = state.uri.toString();

  // 1. Найти начало нашей строки
  const marker = 'tgWebAppData=';
  final idx = uriStr.indexOf(marker);
  if (idx == -1) return null;

  // 2. Вырезать всё после "tgWebAppData="
  final raw = uriStr.substring(idx + marker.length);

  // 3. Двойной decode (Telegram сначала делает encodeURIComponent,
  //    затем снова percent-encode всей query)
  final once = Uri.decodeComponent(raw);
  final twice = Uri.decodeComponent(once);

  // 4. Получаем словарь: "query_id=…&user={…}&…"
  final topLevel = Uri.splitQueryString(twice);

  // 5. JSON-поле user
  final userJson = topLevel['user'];
  if (userJson == null) return null;
  GetItUtils.logger.w('userJson ${userJson}');

  final Map<String, dynamic> userMap = jsonDecode(userJson);
  GetItUtils.logger.w('data USER ${userMap['id']}');

  // 6. Собираем модель
  final data = AuthDataModel(
    id: (userMap['id'] as num).toInt(),
    firstName: userMap['first_name'] as String?,
    lastName: userMap['last_name'] as String?,
    username: userMap['username'] as String?,
    photoUrl: userMap['photo_url'] as String?,
    token: topLevel['query_id']!, // будет String
  );

  GetItUtils.logger.w('data USER ${data}');
}
