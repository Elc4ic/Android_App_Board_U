import 'package:board_client/data/repository/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/chat.pb.dart';
import '../../../values/values.dart';
import '../../advertisement/widget/my_dialog.dart';
import 'custom_shape.dart';

class SentMessageScreen extends StatelessWidget {
  const SentMessageScreen({
    super.key,
    required this.message,
    required this.chatRepository,
    required this.token, required this.messages,
  });

  final Message message;
  final ChatRepository chatRepository;
  final String? token;
  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: InkWell(
              onLongPress: () => myDialog(context, () async {
                await chatRepository.deleteMessage(message.id, token);
                messages.remove(message);
                context.pop();
              }, SC.DELETE_MESSAGE),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  color: MyColorConst.blue1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message.message,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            message.createdAt,
                            maxLines: 2,
                            style:
                                const TextStyle(color: Colors.white, fontSize: 8),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          CustomPaint(painter: CustomShape(MyColorConst.blue1)),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 18.0, left: 50, top: 15, bottom: 5),
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
