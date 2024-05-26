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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2)),
                  child: const Center(
                    child: Icon(Icons.file_download_sharp),
                  ),
                ),
              ),
              const AddAdForm(),
            ],
          ),
        ),
      ),
    );
  }
}
