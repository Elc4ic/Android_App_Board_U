import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:fixnum/fixnum.dart' as fnum;
import 'package:board_client/generated/ad.pb.dart';
import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/repository/ad_repository.dart';
import '../../data/repository/category_repository.dart';
import '../../data/repository/user_repository.dart';

class AddAdForm extends StatefulWidget {
  const AddAdForm({super.key, required this.result});

  final List<XFile> result;

  @override
  State<AddAdForm> createState() => _AddAdFormState();
}

class _AddAdFormState extends State<AddAdForm> {
  final adRepository = GetIt.I<AdRepository>();
  final userRepository = GetIt.I<UserRepository>();
  final categoryRepository = GetIt.I<CategoryRepository>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  Category? category;

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final images = NavItems.imageFromFilePicker(widget.result);
      Future.delayed(const Duration(seconds: 1), () async {
        await adRepository.addAd(
          Ad(
              title: _titleController.text,
              price: fnum.Int64(int.parse(_priceController.text)),
              description: _descController.text,
              user: userRepository.getUser(),
              category: category,
              created: DateTime.now().toString()),
          images,
          userRepository.getToken(),
        );
      });
      context.go(SC.AD_PAGE);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Category>? categories = categoryRepository.getCategories();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: SC.TITLE,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(9.0),
                  ),
                ),
              ),
              validator:
                  RequiredValidator(errorText: 'Please enter title').call,
            ),
            Markup.dividerH10,
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: SC.PRICE,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(9.0),
                  ),
                ),
              ),
              validator:
                  RequiredValidator(errorText: 'Please enter price').call,
            ),
            Markup.dividerH10,
            TextFormField(
              maxLines: 3,
              controller: _descController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: SC.DECSRIPTION,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(9.0),
                  ),
                ),
              ),
            ),
            Markup.dividerH10,
            DropdownButtonFormField(
              items: categories?.map((Category category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.name),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() => category = newValue);
              },
              value: category,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(9.0),
                  ),
                ),
              ),
            ),
            Markup.dividerH10,
            ElevatedButton(
              onPressed: _submitForm,
              child: Styles.Text16(SC.PUBLISH_AD),
            ),
          ],
        ),
      ),
    );
  }
}
