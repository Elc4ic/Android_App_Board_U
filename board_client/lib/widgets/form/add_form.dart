import 'package:board_client/data/service/ad_service.dart';
import 'package:board_client/data/service/category_service.dart';
import 'package:board_client/data/service/user_service.dart';
import 'package:fixnum/fixnum.dart';
import 'package:board_client/generated/ad.pb.dart';
import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:image_picker/image_picker.dart';

class AddAdForm extends StatefulWidget {
  const AddAdForm({super.key, required this.result, this.ad});

  final Ad? ad;
  final List<XFile> result;

  @override
  State<AddAdForm> createState() => _AddAdFormState();
}

class _AddAdFormState extends State<AddAdForm> {
  final adRepository = GetIt.I<AdService>();
  final userRepository = GetIt.I<UserService>();
  final categoryRepository = GetIt.I<CategoryService>();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  Category? category;
  List<Category>? categories;

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final images = NavItems.imagesFromFiles(widget.result);
        Future.delayed(const Duration(seconds: 1), () async {
          await adRepository.addAd(
            Ad(
              id: widget.ad?.id,
              title: Markup.capitalize(_titleController.text),
              price: Int64(int.parse(_priceController.text)),
              description: Markup.capitalize(_descController.text),
              user: userRepository.getUser(),
              category: category,
              created:
                  widget.ad == null ? Markup.dateNow() : widget.ad?.created,
            ),
            images,
            userRepository.getToken(),
          );
        });
        context.go(SC.AD_PAGE);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text((e as GrpcError).message!),
              backgroundColor: MyColorConst.error),
        );
      }
    }
  }

  @override
  void initState() {
    _titleController.text = widget.ad?.title ?? "";
    _priceController.text = widget.ad?.price.toString() ?? "";
    _descController.text = widget.ad?.description ?? "";
    category = widget.ad?.category;
    categories = categoryRepository.getCategories();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
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
              decoration: const InputDecoration(
                labelText: SC.TITLE,
              ),
              validator: RequiredValidator(errorText: SC.REQUIRED_ERROR).call,
            ),
            Markup.dividerH10,
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: SC.PRICE,
              ),
              validator: MultiValidator(
                [
                  RequiredValidator(errorText: SC.REQUIRED_ERROR),
                  PatternValidator(SC.NUM_PATTERN, errorText: SC.NOT_NUM_ERROR),
                ],
              ).call,
            ),
            Markup.dividerH10,
            TextFormField(
              maxLines: 3,
              controller: _descController,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: SC.DECSRIPTION,
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
              ),
            ),
            Markup.dividerH10,
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(SC.PUBLISH_AD,
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
