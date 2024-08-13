import 'dart:typed_data';

import 'package:board_client/bloc/chat_bloc/chat_bloc.dart';
import 'package:board_client/generated/chat.pb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/image_bloc/image_bloc.dart';
import '../../../data/repository/ad_repository.dart';
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
  final _imageBloc = ImageBloc(
    GetIt.I<AdRepository>(),
  );

  @override
  void initState() {
    _imageBloc.add(LoadImageList(widget.chat.ad.id, true, widget.token));
    super.initState();
  }

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
          }, "Вы уверенны, что хотите удалить чат?"),
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
                      child: BlocBuilder<ImageBloc, ImageState>(
                        bloc: _imageBloc,
                        builder: (context, state) {
                          if (state is ImageLoaded) {
                            return Image.memory(
                              width: 100,
                              height: 90,
                              fit: BoxFit.fitWidth,
                              Uint8List.fromList(state.images.first),
                            );
                          }
                          if (state is ImageLoadingFailure) {
                            return Container(
                              width: 100,
                              height: 90,
                              color: Colors.blueAccent,
                            );
                          }
                          return const SizedBox(
                              width: 100,
                              height: 90,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        },
                      ),
                    ),
                    Markup.dividerW10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("05.06.2024  ${widget.chat.target.username}",
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                        Row(
                          children: [
                            Text(widget.chat.ad.title,
                                style: Theme.of(context).textTheme.bodyMedium),
                            Text("  ${widget.chat.ad.price}P",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                        Markup.dividerH10,
                        Text("Последнее сообщение",
                            style: Theme.of(context).textTheme.bodySmall),
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
