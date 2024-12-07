
import 'package:board_client/cubit/chat_bloc/chat_cubit.dart';
import 'package:board_client/generated/chat.pb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../values/values.dart';
import '../../advertisement/widget/my_dialog.dart';

class ChatRow extends StatefulWidget {
  const ChatRow({super.key, required this.chat, required this.chatBloc});

  final ChatPreview chat;
  final ChatCubit chatBloc;

  @override
  State<ChatRow> createState() => _ChatRowState();
}

class _ChatRowState extends State<ChatRow> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () => myDialog(context, () async {
        widget.chatBloc.deleteChat(widget.chat);
        context.pop();
      }, "Вы уверенны, что хотите удалить чат?"),
      onTap: () {
        context.push("/chat/${widget.chat.id}");
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: Markup.padding_all_8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.network(
                      gaplessPlayback: true,
                      width: Const.cellWidth,
                      fit: BoxFit.fitWidth,
                      "${Const.image_ad_api}${widget.chat.ad.id}"),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: Markup.padding_h8_v16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.network(
                              gaplessPlayback: true,
                              fit: BoxFit.contain,
                              "${Const.image_avatar_api}${widget.chat.target.id}",
                            ),
                          ),
                        ),
                        Markup.dividerW5,
                        Text(widget.chat.target.name,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    Row(
                      children: [
                        Text("${widget.chat.ad.price} ${SC.RUBLES}",
                            style: Theme.of(context).textTheme.bodySmall),
                        Markup.dividerW5,
                        Text(Markup.substringText(widget.chat.ad.title, 21),
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    Text("Последнее сообщение:",
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(
                      (widget.chat.lastMessage.message.length < 18)
                          ? (widget.chat.lastMessage.message)
                          : "${widget.chat.lastMessage.message.substring(0, 17)}...",
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
              ),
            ),
            widget.chat.unread > 0
                ? Padding(
                    padding: const EdgeInsets.only(right: 16, top: 16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(100),
                          radius: 14,
                          child: Text(widget.chat.unread.toString()),
                        )
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
