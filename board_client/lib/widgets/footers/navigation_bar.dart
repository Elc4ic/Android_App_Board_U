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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: SC.MAIN_LABEL),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: SC.FAVORITE_LABEL),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_kanban), label: SC.AD_LABEL),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: SC.CHATS_LABEL),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: SC.SETTINGS_LABEL),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location =
        GoRouter.of(context).routeInformationProvider.value.uri.path;
    if (location.startsWith(NavItems.paths[0])) {
      return 0;
    }
    if (location.startsWith(NavItems.paths[1])) {
      return 1;
    }
    if (location.startsWith(NavItems.paths[2])) {
      return 2;
    }
    if (location.startsWith(NavItems.paths[3])) {
      return 3;
    }
    if (location.startsWith(NavItems.paths[4])) {
      return 4;
    }
    return 0;
  }

  void onTap(int index) {
    context.go(NavItems.paths[index]);
  }
}
