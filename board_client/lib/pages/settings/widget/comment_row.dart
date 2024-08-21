import 'package:board_client/values/values.dart';
import 'package:board_client/widgets/mini_profile.dart';
import 'package:flutter/material.dart';

import '../../../generated/user.pb.dart';

class CommentRow extends StatelessWidget {
  const CommentRow({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: Markup.padding_all_8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MiniProfileButton(user: comment.owner),
              Padding(
                padding: Markup.padding_h_16_v_4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(comment.rating.toString(),
                            style: Theme.of(context).textTheme.titleMedium),
                        const Icon(
                          size: 20,
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                    Text(comment.text,
                        style: Theme.of(context).textTheme.bodyMedium),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(comment.created,
                          style: Theme.of(context).textTheme.bodySmall),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
