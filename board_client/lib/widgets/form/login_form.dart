import 'package:board_client/data/service/ad_service.dart';
import 'package:board_client/data/service/user_service.dart';
import 'package:board_client/routing/not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../data/service/category_service.dart';
import '../../data/service/chat_service.dart';
import '../../values/values.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _AddAdFormState();
}

class _AddAdFormState extends State<LoginForm> {
  final userRepository = GetIt.I<UserService>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      errorSnail(context, () async {
        String token = await userRepository.login(
            _usernameController.text, _passwordController.text);
        GetIt.I<AdService>().initClient(token);
        GetIt.I<CategoryService>().initClient(token);
        GetIt.I<ChatService>().initClient(token);
        context.go(SC.MAIN_PAGE);
      });
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
              ),
              validator: RequiredValidator(errorText: SC.REQUIRED_ERROR).call,
            ),
            Markup.dividerH10,
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                labelText: SC.PASSWORD,
              ),
              validator: RequiredValidator(errorText: SC.REQUIRED_ERROR).call,
            ),
            TextButton(
              onPressed: () {
                context.push(SC.SIGNUP_PAGE);
              },
              child: Text(SC.SIGN_UP,
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            Markup.dividerH10,
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(SC.LOGIN),
            ),
          ],
        ),
      ),
    );
  }
}
