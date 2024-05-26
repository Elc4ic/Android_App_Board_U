import 'package:board_client/widgets/form/sign_up_form.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  State<SignUpPage> createState() => _SignUpPageState();
}

@override
class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            SignUpForm(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
