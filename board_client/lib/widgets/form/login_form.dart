import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../data/repository/user_repository.dart';
import '../../values/values.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _AddAdFormState();
}

class _AddAdFormState extends State<LoginForm> {
  final userRepository = GetIt.I<UserRepository>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await userRepository.login(
          _usernameController.text, _passwordController.text);
      NavItems.resetAllBranches(context);
      context.go(SC.MAIN_PAGE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: SC.USERNAME,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(9.0),
                  ),
                ),
              ),
              validator:
                  RequiredValidator(errorText: 'Please enter login').call,
            ),
            Markup.dividerH10,
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                labelText: SC.PASSWORD,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(9.0),
                  ),
                ),
              ),
              validator:
                  RequiredValidator(errorText: 'Please enter password').call,
            ),
            TextButton(
              onPressed: () {
                context.push(SC.SIGNUP_PAGE);
              },
              child: Styles.Text12(SC.SIGN_UP),
            ),
            Markup.dividerH10,
            ElevatedButton(
              onPressed: _submitForm,
              child: Styles.Text16(SC.LOGIN),
            ),
          ],
        ),
      ),
    );
  }
}
