import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod_overview/feature/home/home_screen.dart';
import 'package:flutter_riverpod_overview/feature/post/post_screen.dart';
import 'package:flutter_riverpod_overview/feature/user/user_screen.dart';
import 'package:go_router/go_router.dart';

abstract class _ScreenNames {
  static const home = 'home';
  static const userList = 'userList';
  static const postList = 'postList';
}

abstract class RoutesNames {
  static const home = '/${_ScreenNames.home}';
  static const userList = '$home/${_ScreenNames.userList}';
  static const postList = '$home/${_ScreenNames.postList}';
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: RoutesNames.userList,
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (_, __, child) => NoTransitionPage(child: HomeScreen(child: child)),
      routes: [
        GoRoute(
          path: RoutesNames.userList,
          pageBuilder: (_, __) => const NoTransitionPage(child: UserScreen()),
        ),
        GoRoute(
          path: RoutesNames.postList,
          pageBuilder: (_, __) => const NoTransitionPage(child: PostScreen()),
        ),
      ],
    ),
  ],
);
