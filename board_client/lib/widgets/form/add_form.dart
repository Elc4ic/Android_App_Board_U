import 'package:fixnum/fixnum.dart' as fnum;
import 'package:board_client/generated/ad.pb.dart';
import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../data/repository/ad_repository.dart';

class AddAdForm extends StatefulWidget {
  const AddAdForm({super.key});

  @override
  State<AddAdForm> createState() => _AddAdFormState();
}

class _AddAdFormState extends State<AddAdForm> {
  final adRepository = GetIt.I<AdRepository>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String _titleErrorText = '';
  String _priceErrorText = '';
  String _descErrorText = '';

  void _validateText(String value) {
    if (value.isEmpty) {
      setState(() {
        _titleErrorText = SC.REQUARIED;
      });
    } else {
      setState(() {
        _titleErrorText = '';
      });
    }
  }

  void _validateDesc(String value) {
    if (value.isEmpty) {
      setState(() {
        _descErrorText = SC.REQUARIED;
      });
    } else {
      setState(() {
        _descErrorText = '';
      });
    }
  }

  void _validatePrice(String value) {
    if (value.isEmpty) {
      setState(() {
        _priceErrorText = SC.REQUARIED;
      });
    } else if (!isPriceValid(value)) {
      setState(() {
        _priceErrorText = SC.VALID;
      });
    } else {
      setState(() {
        _priceErrorText = '';
      });
    }
  }

  bool isPriceValid(String s) {
    if (s == null) {
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
      await adRepository.addAd(
        Ad(
          title: _titleController.text,
          price: fnum.Int64(_priceController.text as int),
          description: _descController.text,
        ),
      );
      context.pushReplacement(SC.AD_PAGE);
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
              controller: _titleController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: SC.TITLE,
                errorText: _titleErrorText,
              ),
              validator: (value) => _titleErrorText,
              onChanged: _validateText,
            ),
            Markup.dividerH10,
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: SC.PRICE,
                errorText: _priceErrorText,
              ),
              validator: (value) => _priceErrorText,
              onChanged: _validatePrice,
            ),
            Markup.dividerH10,
            TextFormField(
              controller: _descController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: SC.DECSRIPTION,
                errorText: _titleErrorText,
              ),
              validator: (value) => _descErrorText,
              onChanged: _validateDesc,
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
