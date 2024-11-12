import 'dart:async';

import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:board_client/generated/chat.pb.dart';
import 'package:board_client/pages/chats/widget/received_message.dart';
import 'package:board_client/pages/chats/widget/sent_message.dart';
import 'package:board_client/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../data/service/chat_service.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.chatId});

  final String chatId;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  var chatService = GetIt.I<ChatService>();
  ChatPreview? chat;
  final TextEditingController controller = TextEditingController();
  List<Message> messages = [];
  bool isLoading = false;
  final StreamController<SendMessageRequest> streamController =
      StreamController<SendMessageRequest>();
  final ScrollController scrollController = ScrollController();
  late final _userBloc = UserCubit.get(context);

  String? error;

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  initAsync() async {
    await fetchChatsHistory();
    startListeningMessageRequest();
    Future.delayed(const Duration(milliseconds: 400), () {
      scrollDown();
    });
  }

  void startListeningMessageRequest() {
    final stream = chatService.sendMessage(streamController.stream);
    stream.listen((value) {
      if (value.sender != "Server") {
        setState(() {
          messages.add(value);
        });
      }
    });
  }

  void addMessage(String message) {
    final user = _userBloc.getUser();
    final req = SendMessageRequest(
        message: message,
        receiver: user.id,
        chatId: widget.chatId);
    streamController.sink.add(req);
  }

  void _sendMessage() {
    final messageText = controller.text;

    if (messageText.isNotEmpty) {
      addMessage(messageText);

      controller.clear();
      scrollDown();
      setState(() {});
    }
  }

  fetchChatsHistory() async {
    try {
      setState(() {
        isLoading = true;
      });
      final res = await chatService.getMessages(widget.chatId);
      chat = res.chat;
      messages.addAll(res.messages);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка: $error'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    streamController.close();
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("${chat?.target.name}"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isLoading
              ? loadingWidget()
              : error != null
                  ? errorWidget()
                  : messages.isNotEmpty
                      ? Expanded(
                          child: Column(
                            children: [
                              cardWidget(),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  reverse: true,
                                  controller: scrollController,
                                  itemCount: messages.length,
                                  itemBuilder: ((context, index) {
                                    Message message =
                                        messages[messages.length - index - 1];
                                    final user = _userBloc.getUser();
                                    return (message.sender.username.toLowerCase() ==
                                            user?.username.toLowerCase())
                                        ? SentMessageScreen(
                                            message: message,
                                            chatService: chatService,
                                            token: _userBloc.getToken(),
                                            messages: messages,
                                          )
                                        : ReceivedMessageScreen(message: message);
                                  }),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: Text(
                            SC.WELCOME,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
          Container(
            padding: Markup.padding_all_8,
            height: 70,
            child: TextField(
              controller: controller,
              enabled: !isLoading,
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.message),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.black)),
                  suffixIcon: IconButton(
                      onPressed: () {
                        _sendMessage();
                      },
                      icon: const Icon(Icons.send)),
                  hintText: SC.MESSAGE),
              onChanged: (value) {
                if (value.isNotEmpty) {}
              },
            ),
          ),
        ],
      ),
    );
  }

  loadingWidget() => Expanded(child: Center(child: CircularProgressIndicator()));

  cardWidget() => Card(
    child: InkWell(
      onTap: () {
        context.push("/ad/${chat?.ad.id}");
      },
      child: Padding(
        padding: Markup.padding_all_8,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 60,
                width: 60,
                child: Image.network(
                    gaplessPlayback: true,
                    width: Const.cellWidth,
                    cacheWidth: Const.cardImageWidth,
                    cacheHeight: Const.cardImageHeight,
                    fit: BoxFit.cover,
                    "${Const.image_ad_api}${chat?.ad.id}"),
              ),
            ),
            Markup.dividerW10,
            Text(
                (chat!.ad.title.length > 30)
                    ? "${chat?.ad.title.substring(0, 29)}..."
                    : chat!.ad.title,
                style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
      ),
    ),
  );

  errorWidget() => Center(
      child: Text(error ?? "Something went wrong",
          style: const TextStyle(color: Colors.red)));
}
