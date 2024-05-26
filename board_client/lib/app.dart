
import 'package:board_client/routing/router.dart';
import 'package:board_client/theme.dart';
import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: SC.APP_TITLE,
      theme: mainTheme(context),
      routerConfig: router,
    );
  }
}