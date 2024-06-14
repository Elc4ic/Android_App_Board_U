import 'package:board_client/widgets/form/add_form.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../values/values.dart';

class AddAdPage extends StatefulWidget {
  const AddAdPage({super.key, required this.token});

  final String token;

  @override
  State<AddAdPage> createState() => _AddAdPageState();
}

class _AddAdPageState extends State<AddAdPage> {
  List<XFile> files = [];

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
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2)),
                  child: InkWell(
                    onTap: _imagePick,
                    child: const Center(
                      child: Icon(Icons.file_download_sharp),
                    ),
                  ),
                ),
              ),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: NavItems.wrapFiles(files),
              ),
              AddAdForm(result: files),
            ],
          ),
        ),
      ),
    );
  }

  Future _imagePick() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (picked != null) {
        files.add(picked);
      }
    });
  }
}
