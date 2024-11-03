import 'package:board_client/data/service/user_service.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:grpc/grpc_connection_interface.dart';

import '../../values/values.dart';

class CommentForm extends StatefulWidget {
  const CommentForm({required this.user, super.key});

  final User? user;

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final userRepository = GetIt.I<UserService>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  double rating = 0;

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false || rating != 0) {
      try {
        Future.delayed(const Duration(seconds: 1), () async {
          await userRepository.addComment(Comment(
            text: _textController.text,
            rating: rating.toInt(),
            convicted: widget.user,
            owner: userRepository.getUser(),
            created: Markup.dateNow(),
          ));
        });
        context.pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text((e as GrpcError).message!),
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
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (double value) {
                setState(() {
                  rating = value;
                });
              },
            ),
            Markup.dividerH10,
            TextFormField(
              controller: _textController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: SC.TITLE_COMMENT,
              ),
              validator: RequiredValidator(errorText: SC.REQUIRED_ERROR).call,
            ),
            Markup.dividerH10,
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(SC.ADD_COMMENT),
            ),
          ],
        ),
      ),
    );
  }
}
