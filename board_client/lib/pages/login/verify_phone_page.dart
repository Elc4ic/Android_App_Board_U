import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../data/service/user_service.dart';
import '../../values/values.dart';

class VerifyPhonePage extends StatelessWidget {
  const VerifyPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        ],
      ),
    );
  }
}

class CodeForm extends StatefulWidget {
  const CodeForm({super.key});

  @override
  State<CodeForm> createState() => _CodeFormState();
}

class _CodeFormState extends State<CodeForm> {
  final userRepository = GetIt.I<UserService>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await userRepository.signUp(
          _usernameController.text,
          _passwordController.text,
          _phoneController.text,
        );
        context.go(SC.LOGIN_PAGE);
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
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(9.0),
                  ),
                ),
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
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(9.0),
                  ),
                ),
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
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(9.0),
                  ),
                ),
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
