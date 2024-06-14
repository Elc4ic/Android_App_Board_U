import 'package:board_client/bloc/chat_bloc/chat_bloc.dart';
import 'package:board_client/generated/chat.pb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../data/repository/chat_repository.dart';
import '../../../values/values.dart';
import '../../advertisement/widget/my_dialog.dart';

class ChatRow extends StatefulWidget {
  const ChatRow(
      {super.key,
      required this.chat,
      required this.token,
      required this.chatBloc});

  final ChatPreview chat;
  final String? token;
  final ChatBloc chatBloc;

  @override
  State<ChatRow> createState() => _ChatRowState();
}

class _ChatRowState extends State<ChatRow> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        child: InkWell(
          onLongPress: () => myDialog(context, () async {
            GetIt.I<ChatRepository>().deleteChat(widget.chat.id, widget.token);
            context.pop();
            widget.chatBloc.add(LoadChatList());
          }),
          onTap: () {
            context.push("/chat/${widget.chat.id}");
          },
          child: Row(
            children: [
              Padding(
                padding: Markup.padding_all_8,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Markup.dividerW10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Styles.Text12(
                                "05.06.2024  ${widget.chat.target.username}"),
                          ],
                        ),
                        Row(
                          children: [
                            Styles.Text16(widget.chat.ad.title),
                            Styles.TitleText16("  ${widget.chat.ad.price}P"),
                          ],
                        ),
                        Markup.dividerH10,
                        Styles.Text12("Последнее сообщение"),
                      ],
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
