import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../data/service/user_service.dart';
import '../../values/values.dart';

class VerifyPhonePage extends StatelessWidget {
  const VerifyPhonePage({super.key, required this.userID});

  final String userID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CodeForm(userID: userID),
          ],
        ),
      ),
    );
  }
}

class CodeForm extends StatefulWidget {
  const CodeForm({super.key, required this.userID});

  final String userID;

  @override
  State<CodeForm> createState() => _CodeFormState();
}

class _CodeFormState extends State<CodeForm> {
  final userRepository = GetIt.I<UserService>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await userRepository.endIfPhoneValid(widget.userID, _codeController.text);
        context.go(SC.LOGIN_PAGE);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green,
            content: Text("Аккаунт успешно создан"),
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
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Код подтверждения",
              ),
              validator: MultiValidator(
                [
                  RequiredValidator(errorText: SC.REQUIRED_ERROR),
                  MinLengthValidator(4, errorText: SC.PHONE_ERROR),
                  MaxLengthValidator(4, errorText: SC.PHONE_ERROR),
                ],
              ).call,
            ),
            Markup.dividerH10,
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text("Подтвердить"),
            ),
          ],
        ),
      ),
    );
  }
}
