import 'package:board_client/cubit/comment_cubit/comment_cubit.dart';
import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:board_client/data/service/user_service.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:grpc/grpc_connection_interface.dart';

import '../../values/values.dart';

class EditCommentForm extends StatefulWidget {
  const EditCommentForm(
      {super.key, required this.comment, required this.commentBloc});

  final Comment comment;
  final CommentCubit commentBloc;

  @override
  State<EditCommentForm> createState() => _EditCommentFormState();
}

class _EditCommentFormState extends State<EditCommentForm> {
  final userRepository = GetIt.I<UserService>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  double rating = 0;
  double ratingPrev = 0;

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false || rating != 0) {
      try {
        Future.delayed(const Duration(seconds: 1), () async {
          await userRepository.editComment(
            Comment(
              text: _textController.text,
              rating: rating.toInt(),
              convicted: widget.comment.convicted,
              owner: widget.comment.owner,
              created: widget.comment.created,
            ),
            ratingPrev.toInt(),
          );
        });
        widget.commentBloc.loadUserComments();
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
    _textController.text = widget.comment.text ?? '';
    rating = double.parse(widget.comment.rating.toString());
    ratingPrev = rating;
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
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await userRepository.deleteComment(widget.comment.id);
                      widget.commentBloc.loadUserComments();
                      context.pop();
                    },
                    child: Text(SC.DELETE,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
                Markup.dividerW10,
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(SC.EDIT,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
