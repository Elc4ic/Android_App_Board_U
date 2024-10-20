import 'dart:typed_data';

import 'package:board_client/cubit/chat_bloc/chat_cubit.dart';
import 'package:board_client/cubit/image_cubit/image_cubit.dart';
import 'package:board_client/generated/chat.pb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../data/service/chat_service.dart';
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
  final ChatCubit chatBloc;

  @override
  State<ChatRow> createState() => _ChatRowState();
}

class _ChatRowState extends State<ChatRow> {

  late final _imageBloc = ImageCubit.get(context);

  @override
  void initState() {
    _imageBloc.loadImages(widget.chat.ad.id, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onLongPress: () => myDialog(context, () async {
        GetIt.I<ChatService>().deleteChat(widget.chat.id, widget.token);
        widget.chatBloc.loadChats();
        context.pop();
      }, "Вы уверенны, что хотите удалить чат?"),
      onTap: () {
        context.push("/chat/${widget.chat.id}");
      },
      child: Card(
        color: MyColorConst.card,
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
                  child: BlocConsumer<ImageCubit, ImageState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is ImageLoaded) {
                        return Image.memory(
                          gaplessPlayback: true,
                          fit: BoxFit.fill,
                          cacheWidth: Const.ImageWidth,
                          cacheHeight: Const.ImageHeight,
                          Uint8List.fromList(state.images[widget.chat.ad.id]!.first),
                        );
                      }
                      if (state is ImageLoadingFailure) {
                        return const NoImageWidget();
                      }
                      return ShimmeringContainer();
                    },
                  ),
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
                            child: Image.memory(
                              gaplessPlayback: true,
                              fit: BoxFit.fitWidth,
                              Uint8List.fromList(widget.chat.target.avatar),
                            ),
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
                        Text(Markup.substringText(widget.chat.ad.title, 21),
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    Text("Последнее сообщение:",
                        style: Theme.of(context).textTheme.bodySmall),
                    /*   Text(
                      (widget.chat.lastMessage.message.length < 18)
                          ? (widget.chat.lastMessage.message ?? "")
                          : "${widget.chat.lastMessage.message.substring(0, 17)}...",
                    )*/
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
