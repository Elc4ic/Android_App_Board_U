import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../data/repository/user_repository.dart';
import '../../values/values.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _AddAdFormState();
}

class _AddAdFormState extends State<SignUpForm> {
  final userRepository = GetIt.I<UserRepository>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPhoneValid(String s) {
    if (s == null && s.length > 11 && s.length < 11 && !s.startsWith("7")) {
      return false;
    }
    try {
      double.parse(s);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        userRepository.signUp(
          _usernameController.text,
          _passwordController.text,
          _phoneController.text,
        );
        context.go(SC.LOGIN_PAGE);
      } catch (e) {
        _usernameController.clear();
        _passwordController.clear();
        _phoneController.clear();
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
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(9.0),
                  ),
                ),
              ),
              validator: MultiValidator(
                [
                  RequiredValidator(errorText: 'Введите телефонный номер'),
                  MinLengthValidator(11, errorText: 'Введите телефонный номер'),
                ],
              ).call,
            ),
            Markup.dividerH10,
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
              validator: MultiValidator(
                [
                  RequiredValidator(errorText: 'Please enter login'),
                  MinLengthValidator(8,
                      errorText: 'Login must be atlist 8 digit'),
                ],
              ).call,
            ),
            Markup.dividerH10,
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: SC.PASSWORD,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(9.0),
                  ),
                ),
              ),
              validator: MultiValidator(
                [
                  RequiredValidator(errorText: 'Please enter password'),
                  MinLengthValidator(8,
                      errorText: 'Password must be atlist 8 digit'),
                  PatternValidator(r'(?=.*?[#!@$%^&*-])',
                      errorText:
                          'Password must be atlist one special character')
                ],
              ).call,
            ),
            Markup.dividerH10,
            ElevatedButton(
              onPressed: _submitForm,
              child: Styles.Text16(SC.SIGNING_UP),
            ),
          ],
        ),
      ),
    );
  }
}
