import 'package:board_client/pages/advertisement/add_ad_page.dart';
import 'package:board_client/pages/chats/chats_preview_page.dart';
import 'package:board_client/pages/favorite/fav_page.dart';
import 'package:board_client/pages/login/login_page.dart';
import 'package:board_client/pages/login/login_redirect_page.dart';
import 'package:board_client/pages/login/sign_up_page.dart';
import 'package:board_client/pages/main/category_page.dart';
import 'package:board_client/pages/main/main_page.dart';
import 'package:board_client/pages/settings/settings_page.dart';
import 'package:board_client/widgets/footers/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../data/repository/user_repository.dart';
import '../pages/main/ad_page.dart';
import '../pages/advertisement/my_ads_page.dart';
import 'not_found_page.dart';

final userRepository = GetIt.I<UserRepository>();

GoRouter router = GoRouter(
  initialLocation: '/home',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/ad/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return AdPage(id: int.parse(id));
      },
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) {
        return const AddAdPage(token: "sscsc");
      },
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return const MaterialPage(child: LoginPage());
      },
    ),
    GoRoute(
      path: '/signup',
      pageBuilder: (context, state) {
        return const MaterialPage(child: SignUpPage());
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) {
        return AppScaffold(body: child);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const MainPage(),
              routes: [
                GoRoute(
                  path: ':category',
                  builder: (context, state) {
                    final index = state.pathParameters['category']!;
                    return CategoryPage(categoryIndex: int.parse(index));
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/my',
              builder: (context, state) {
                if (userRepository.getToken() == null) {
                  return const LoginRedirectPage();
                }
                return const MyAdsPage();
              },
              routes: [
                GoRoute(
                  path: 'change/:id',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return const MyAdsPage();
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) {
                if (userRepository.getToken() == null) {
                  return const LoginRedirectPage();
                }
                return const FavPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chats',
              builder: (context, state) {
                if (userRepository.getToken() == null) {
                  return const LoginRedirectPage();
                }
                final search = state.uri.queryParameters['search'];
                return const ChatsPreviewPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) {
                if (userRepository.getToken() == null) {
                  return const LoginRedirectPage();
                }
                return const SettingsPage();
              },
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const AppScaffold(
    body: NotFoundScreen(),
  ),
);
