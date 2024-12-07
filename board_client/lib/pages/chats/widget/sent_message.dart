import 'package:board_client/data/service/chat_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../cubit/app_cubit/app_cubit.dart';
import '../../../generated/chat.pb.dart';
import '../../../values/values.dart';
import '../../advertisement/widget/my_dialog.dart';

class SentMessageScreen extends StatelessWidget {
  const SentMessageScreen({
    super.key,
    required this.message,
    required this.chatService,
    required this.messages,
  });

  final Message message;
  final ChatService chatService;
  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = InkWell(
      onLongPress: () => myDialog(context, () async {
        await chatService.deleteMessage(message.id);
        messages.remove(message);
        context.pop();
      }, SC.DELETE_MESSAGE),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: AppCubit.get(context).scheme.primary.withAlpha(100),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            )),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
              minWidth: MediaQuery.of(context).size.width * 0.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.message,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Markup.dividerH10,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    NavItems.formatDate(message.createdAt),
                    maxLines: 2,
                    style: const TextStyle(color: Colors.white, fontSize: 8),
                  )
                ],
              )
            ],
          ),
        ),
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
