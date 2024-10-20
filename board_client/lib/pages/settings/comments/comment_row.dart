import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/mini_profile.dart';
import 'package:flutter/material.dart';

import '../../../generated/user.pb.dart';
import '../../../widgets/form/edit_comment_form.dart';

class CommentRow extends StatelessWidget {
  const CommentRow(
      {super.key,
      required this.comment,
      required this.isMine,
      required this.userBloc});

  final bool isMine;
  final Comment comment;
  final UserCubit userBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Markup.padding_v_4,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MiniProfileButton(user: comment.owner),
                  ),
                  Visibility(
                    visible: isMine,
                    child: IconButton(
                      tooltip: SC.EDIT,
                      icon: const Icon(Icons.mode_edit),
                      onPressed: () =>
                          editCommentDialog(context, userBloc, comment),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: Markup.padding_all_12,
                            child: Row(
                              children: [
                                Text(comment.rating.toString(),
                                    style:
                                        Theme.of(context).textTheme.titleMedium),
                                const Icon(
                                  size: 20,
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Container(
                          padding: Markup.padding_all_4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: Markup.padding_all_4,
                                child: Text(comment.text,
                                    style: Theme.of(context).textTheme.bodyMedium),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(comment.created,
                                    style: Theme.of(context).textTheme.bodySmall),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> editCommentDialog(
    BuildContext context, UserCubit commentBloc, Comment comment) async {
  return showDialog<void>(
    context: context,
    builder: (context) => Dialog.fullscreen(
      backgroundColor: Colors.white,
      child: EditCommentForm(comment: comment, commentBloc: commentBloc),
    ),
  );
}
