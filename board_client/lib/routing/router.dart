import 'package:board_client/pages/advertisement/add_ad_page.dart';
import 'package:board_client/pages/chats/chats_preview_page.dart';
import 'package:board_client/pages/favorite/fav_page.dart';
import 'package:board_client/pages/login/login_page.dart';
import 'package:board_client/pages/login/login_redirect_page.dart';
import 'package:board_client/pages/login/sign_up_page.dart';
import 'package:board_client/pages/main/main_page.dart';
import 'package:board_client/pages/settings/set_address_page.dart';
import 'package:board_client/pages/settings/settings_page.dart';
import 'package:board_client/pages/settings/comments/user_comment_page.dart';
import 'package:board_client/widgets/footers/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fixnum/fixnum.dart';

import '../pages/advertisement/edit_ad_page.dart';
import '../pages/chats/message_page.dart';
import '../pages/main/ad_page.dart';
import '../pages/advertisement/my_ads_page.dart';
import '../pages/settings/comments/add_comment_page.dart';
import '../pages/settings/comments/comment_page.dart';
import '../pages/settings/user_page.dart';
import 'not_found_page.dart';

GoRouter router = GoRouter(
  initialLocation: '/home',
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: '/ad/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return AdPage(idAd: Int64(int.parse(id)));
      },
    ),
    GoRoute(
      path: '/comments/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return CommentPage(userId: Int64(int.parse(id)));
      },
    ),
    GoRoute(
      path: '/usercomments',
      builder: (context, state) {
        return const UserCommentPage();
      },
      routes: [
        GoRoute(
          path: 'change/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return EditAdPage(adId: Int64(int.parse(id)));
          },
        ),
      ],
    ),
    GoRoute(
      path: '/user/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return UserPage(id: Int64(int.parse(id)));
      },
    ),
    GoRoute(
      path: '/chat/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return MessagePage(chatId: int.parse(id));
      },
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) {
        return const AddAdPage();
      },
    ),
    GoRoute(
      path: '/addcomment/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return AddCommentPage(convictedId: Int64(int.parse(id)));
      },
    ),
    GoRoute(
      path: '/setaddress',
      builder: (context, state) {
        return const SetAddressPage();
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
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/my',
              builder: (context, state) {
                return const LoginChecker(child: MyAdsPage());
              },
              routes: [
                GoRoute(
                  path: 'change/:id',
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return EditAdPage(adId: Int64(int.parse(id)));
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
                return const LoginChecker(child: FavPage());
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chats',
              builder: (context, state) {
                return const LoginChecker(child: ChatsPreviewPage());
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) {
                return const LoginChecker(child: SettingsPage());
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
