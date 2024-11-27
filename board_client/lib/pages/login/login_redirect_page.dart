import 'dart:async';

import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../values/values.dart';

class LoginChecker extends StatefulWidget {
  const LoginChecker({super.key, required this.child});

  final Widget child;

  @override
  State<LoginChecker> createState() => _LoginCheckerState();
}

class _LoginCheckerState extends State<LoginChecker> {
  late final userBloc = UserCubit.get(context);

  bool pressed = false;
  String clientID = "2d9bfe59161142bba4b0bb47b1c855f0";

  @override
  Widget build(BuildContext context) {
    if (userBloc.getToken() == null && !userBloc.auth) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (userBloc.getToken() != null) {
            userBloc.auth = true;
            timer.cancel();
          }
        });
      });
      return Center(
        child: ElevatedButton(
          onPressed: () {
            context.push(SC.LOGIN_PAGE);
          },
          child: Text(SC.LOGIN),
        ),
      );
    }
    return widget.child;
  }
}
