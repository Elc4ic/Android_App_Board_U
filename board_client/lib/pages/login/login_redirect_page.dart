import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../values/values.dart';

class LoginRedirectPage extends StatefulWidget {
  const LoginRedirectPage({super.key});
  

  @override
  State<LoginRedirectPage> createState() => _LoginRedirectPageState();
}

class _LoginRedirectPageState extends State<LoginRedirectPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
          child: ElevatedButton(
    onPressed: () {context.push(SC.LOGIN_PAGE);},
    child: Styles.Text16(SC.LOGIN),
          ),
        );
  }
}
