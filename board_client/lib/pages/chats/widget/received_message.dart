import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../../generated/chat.pb.dart';

class ReceivedMessageScreen extends StatelessWidget {
  final Message message;

  const ReceivedMessageScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    message.createdAt,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              )),
        ),
      ],
    ));

    return Padding(
      padding: const EdgeInsets.only(right: 50.0, left: 18, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}
