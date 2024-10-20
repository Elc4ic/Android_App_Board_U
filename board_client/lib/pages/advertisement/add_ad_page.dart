import 'dart:io';

import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/form/add_form.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class AddAdPage extends StatefulWidget {
  const AddAdPage({super.key});

  @override
  State<AddAdPage> createState() => _AddAdPageState();
}

class _AddAdPageState extends State<AddAdPage> {
  List<XFile> files = [];

  List<Widget> wrapFiles(List<XFile> files, BuildContext context) {
    return List.generate(
      files.length,
      (index) => TextButton(
        onPressed: () {
          setState(() {
            files.removeAt(index);
          });
        },
        child: SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            children: [
              Image.file(
                File(files[index].path),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: Markup.padding_h_4,
                child: Text((index + 1).toString(),
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              const Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.close, size: 20, color: Colors.black87)),
            ],
          ),
        ),
      ),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 150,
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
                children: wrapFiles(files, context),
              ),
              AddAdForm(result: files),
            ],
          ),
        ),
      ),
    );
  }

  Future _imagePick() async {
    final picked = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    setState(() {
      if (picked != null) {
        files.add(picked);
      }
    });
  }
}
