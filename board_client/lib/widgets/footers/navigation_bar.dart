import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.body});

  final Widget body;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int prev_index = 0;
  late UserCubit user = UserCubit.get(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.body,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: onTap,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: SC.MAIN_LABEL),
          const BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: SC.FAVORITE_LABEL),
          const BottomNavigationBarItem(
              icon: Icon(Icons.view_kanban), label: SC.AD_LABEL),
          BottomNavigationBarItem(
              icon: Badge(
                  label: user.newChat == 0 ? null : Text("${user.newChat}"),
                  child: const Icon(Icons.account_box)),
              label: SC.CHATS_LABEL),
          const BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: SC.SETTINGS_LABEL),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location =
        GoRouter.of(context).routeInformationProvider.value.uri.path;
    for (int i = 0; i < 5; i++) {
      if (location.startsWith(NavItems.paths[i])) {
        setState(() {
          prev_index = i;
        });
        return i;
      }
    }
    return prev_index;
  }

  void onTap(int index) {
    context.go(NavItems.paths[index]);
  }
}
