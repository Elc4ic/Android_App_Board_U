import 'dart:typed_data';

import 'package:board_client/bloc/chat_bloc/chat_bloc.dart';
import 'package:board_client/generated/chat.pb.dart';
import 'package:board_client/widgets/black_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/image_bloc/image_bloc.dart';
import '../../../data/repository/ad_repository.dart';
import '../../../data/repository/chat_repository.dart';
import '../../../values/values.dart';
import '../../../widgets/shimerring_container.dart';
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
  Widget build(BuildContext context) {
    _imageBloc.add(LoadImageList(widget.chat.ad.id, true));
    return SizedBox(
      height: 106,
      child: InkWell(
        onLongPress: () => myDialog(context, () async {
          GetIt.I<ChatRepository>().deleteChat(widget.chat.id, widget.token);
          widget.chatBloc.add(LoadChatList());
          context.pop();
        }, "Вы уверенны, что хотите удалить чат?"),
        onTap: () {
          context.push("/chat/${widget.chat.id}");
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: Markup.padding_all_8,
              child: BlocBuilder<ImageBloc, ImageState>(
                bloc: _imageBloc,
                builder: (context, state) {
                  if (state is ImageLoaded) {
                    return Image.memory(
                      gaplessPlayback: true,
                      width: 90,
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
                  return SizedBox(
                      width: 90, height: 90, child: ShimmeringContainer());
                },
              ),
            ),
            Expanded(
              child: LBlackBox(
                padding: Markup.padding_all_8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.memory(
                            gaplessPlayback: true,
                            fit: BoxFit.fitWidth,
                            Uint8List.fromList(widget.chat.target.avatar),
                          ),
                        ),
                        Markup.dividerW5,
                        Text(widget.chat.target.username,
                            style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                    Row(
                      children: [
                        Text("${widget.chat.ad.price}P",
                            style: Theme.of(context).textTheme.labelMedium),
                        Markup.dividerW5,
                        Text(
                            widget.chat.ad.title.length < 18
                                ? widget.chat.ad.title
                                : "${widget.chat.ad.title.substring(0, 17)}...",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    Text("Последнее сообщение:",
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
