import 'package:board_client/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../values/values.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _AddAdFormState();
}

class _AddAdFormState extends State<SignUpForm> {
  final userRepository = GetIt.I<UserService>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        String userID = await userRepository.signUp(
          _usernameController.text,
          _passwordController.text,
          "+${_phoneController.text}",
        );
        context.push("${SC.VERIFY_PAGE}/$userID");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.green,
            content: Text("Введите 4 последние цифры входящего звонка"),
          ),
        );

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
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
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: SC.PHONE_NUM,
              ),
              validator: MultiValidator(
                [
                  PatternValidator(SC.PHONE_PATTERN, errorText: SC.PHONE_ERROR),
                  RequiredValidator(errorText: SC.REQUIRED_ERROR),
                  MinLengthValidator(11, errorText: SC.PHONE_ERROR),
                  MaxLengthValidator(11, errorText: SC.PHONE_ERROR),
                ],
              ).call,
            ),
            Markup.dividerH10,
            TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: SC.USERNAME,
              ),
              validator: MultiValidator(
                [
                  RequiredValidator(errorText: SC.REQUIRED_ERROR),
                  MinLengthValidator(8, errorText: SC.MIN_LENGHT_8_ERROR),
                ],
              ).call,
            ),
            Markup.dividerH10,
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: SC.PASSWORD,
              ),
              validator: MultiValidator(
                [
                  RequiredValidator(errorText: SC.REQUIRED_ERROR),
                  MinLengthValidator(8, errorText: SC.MIN_LENGHT_8_ERROR),
                  PatternValidator(SC.PASSWORD_PATTERN,
                      errorText: SC.NO_SPEC_SIMBOLS_ERROR)
                ],
              ).call,
            ),
            Markup.dividerH10,
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(SC.SIGNING_UP),
            ),
          ],
        ),
      ),
    );
  }
}
