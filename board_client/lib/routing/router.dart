import 'package:board_client/pages/advertisement/add_ad_page.dart';
import 'package:board_client/pages/chats/chats_page.dart';
import 'package:board_client/pages/favorite/fav_page.dart';
import 'package:board_client/pages/login/login_page.dart';
import 'package:board_client/pages/login/login_redirect_page.dart';
import 'package:board_client/pages/login/sign_up_page.dart';
import 'package:board_client/pages/main/main_page.dart';
import 'package:board_client/pages/settings/settings_page.dart';
import 'package:board_client/widgets/footers/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:fixnum/fixnum.dart' as fnum;

import '../data/repository/user_repository.dart';
import '../pages/advertisement/ad_page.dart';
import '../pages/advertisement/my_ads_page.dart';
import 'not_found_page.dart';

enum AppRoute {
  home,
  settings,
  chats,
  my,
  add,
  change,
  login,
  fav,
  ad,
  category,
  signup
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final userRepository = GetIt.I<UserRepository>();

GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/login',
      name: AppRoute.login.name,
      pageBuilder: (context, state) {
        return const MaterialPage(child: LoginPage());
      },
    ),
    GoRoute(
      path: '/signup',
      name: AppRoute.signup.name,
      pageBuilder: (context, state) {
        return const MaterialPage(child: SignUpPage());
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return AppScaffold(body: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          name: AppRoute.home.name,
          pageBuilder: (context, state) {
            return const MaterialPage(child: MainPage(search: ""));
          },
        ),
        GoRoute(
          path: '/home/:category',
          name: AppRoute.category.name,
          pageBuilder: (context, state) {
            final category = state.pathParameters['category']!;
            return MaterialPage(child: MainPage(search: category));
          },
        ),
        GoRoute(
          path: '/ad/:id',
          name: AppRoute.ad.name,
          pageBuilder: (context, state) {
            final id = state.pathParameters['id']!;
            return MaterialPage(child: AdPage(id: int.parse(id)));
          },
        ),
        GoRoute(
          path: '/my',
          name: AppRoute.my.name,
          pageBuilder: (context, state) {
            if (userRepository.getUser() == null) {
              return const MaterialPage(child: LoginRedirectPage());
            }
            return const MaterialPage(child: MyAdsPage());
          },
          routes: [
            GoRoute(
              path: 'add',
              name: AppRoute.add.name,
              pageBuilder: (context, state) {
                return const MaterialPage(child: AddAdPage(token: "sscsc"));
              },
            ),
            GoRoute(
              path: 'change/:id/:token',
              name: AppRoute.change.name,
              pageBuilder: (context, state) {
                final id = state.pathParameters['id']!;
                final token = state.pathParameters['token']!;
                return const MaterialPage(child: MyAdsPage());
              },
            ),
          ],
        ),
        GoRoute(
          path: '/favorites',
          name: AppRoute.fav.name,
          pageBuilder: (context, state) {
            if (userRepository.getUser() == null) {
              return const MaterialPage(child: LoginRedirectPage());
            }
            return const MaterialPage(child: FavPage());
          },
        ),
        GoRoute(
          path: '/chats',
          name: AppRoute.chats.name,
          pageBuilder: (context, state) {
            if (userRepository.getUser() == null) {
              return const MaterialPage(child: LoginRedirectPage());
            }
            final search = state.uri.queryParameters['search'];
            return const MaterialPage(child: ChatsPage());
          },
        ),
        GoRoute(
          path: '/settings',
          name: AppRoute.settings.name,
          pageBuilder: (context, state) {
            final user = userRepository.getUser();
            if (user == null) {
              return const MaterialPage(child: LoginRedirectPage());
            }
            return MaterialPage(child: SettingsPage(user: user));
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const AppScaffold(
    body: NotFoundScreen(),
  ),
);
