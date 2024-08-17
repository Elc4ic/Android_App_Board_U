
import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/mini_profile.dart';
import 'package:flutter/material.dart';

import '../../../generated/user.pb.dart';

class CommentRow extends StatelessWidget {
  const CommentRow({super.key, required this.comment, required this.token});

  final Comment comment;
  final String? token;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Card(
        child: Padding(
          padding: Markup.padding_all_8,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Markup.dividerW10,
                  Column(
                    children: [
                      MiniProfile(user: comment.owner),
                      Text(comment.rating.toString(),
                          style: Theme.of(context).textTheme.bodyMedium),
                      Text(comment.text,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
