import 'package:board_client/widgets/form/add_form.dart';
import 'package:flutter/material.dart';


class AddAdPage extends StatefulWidget {
  const AddAdPage({super.key, required this.token});

  final String token;

  @override
  State<AddAdPage> createState() => _AddAdPageState();
}

class _AddAdPageState extends State<AddAdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: AddAdForm()),
    );
  }
}
