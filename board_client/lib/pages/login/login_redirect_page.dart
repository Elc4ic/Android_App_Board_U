import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../data/repository/user_repository.dart';
import '../../values/values.dart';

class LoginChecker extends StatefulWidget {
  LoginChecker({super.key, required this.go});

  final Widget go;

  @override
  State<LoginChecker> createState() => _LoginCheckerState();
}

class _LoginCheckerState extends State<LoginChecker> {
  final userRepository = GetIt.I<UserRepository>();
  bool update = true;

  @override
  Widget build(BuildContext context) {
    if (userRepository.getToken() == null && update) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (userRepository.getToken() != null) {
            update = false;
            timer.cancel();
          }
        });
      });
      return Center(
        child: ElevatedButton(
          onPressed: () {
            context.push(SC.LOGIN_PAGE);
          },
          child: Text(SC.LOGIN, style: Theme.of(context).textTheme.bodyMedium),
        ),
      );
    }
    return widget.go;
  }
}
