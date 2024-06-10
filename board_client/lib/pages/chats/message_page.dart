import 'dart:async';

import 'package:board_client/data/repository/chat_repository.dart';
import 'package:board_client/generated/chat.pb.dart';
import 'package:board_client/pages/chats/widget/received_message.dart';
import 'package:board_client/pages/chats/widget/sent_message.dart';
import 'package:board_client/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:fixnum/fixnum.dart' as fnum;

import '../../data/repository/user_repository.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.chatId});

  final int chatId;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  var chatRepository = GetIt.I<ChatRepository>();
  var userRepository = GetIt.I<UserRepository>();
  ChatPreview? chat;
  final TextEditingController controller = TextEditingController();
  List<Message> messages = [];
  bool isLoading = false;
  final StreamController<SendMessageRequest> streamController =
      StreamController<SendMessageRequest>();
  final ScrollController scrollController = ScrollController();

  String? error;

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  initAsync() async {
    await fetchChatsHistory();
    startListeningMessageRequest();
    addMessage("Join_room");
  }

  void startListeningMessageRequest() {
    final stream = chatRepository.sendMessage(streamController.stream);
    stream.listen((value) {
      if (value.sender != "Server") {
        setState(() {
          messages.add(value);
        });
      }
    });
  }

  void addMessage(String message) {
    final req = SendMessageRequest(
        message: message,
        receiver: chat?.target.id,
        data: DateTime.now().toString(),
        chatId: fnum.Int64(widget.chatId));
    streamController.sink.add(req);
  }

  void _sendMessage() {
    final messageText = controller.text;

    if (messageText.isNotEmpty) {
      addMessage(messageText);

      controller.clear();
      scrollDown();
      setState(() {

      });
    }
  }

  fetchChatsHistory() async {
    try {
      setState(() {
        isLoading = true;
      });
      final res = await chatRepository.getMessages(
          widget.chatId, userRepository.getToken());
      chat = res.chat;
      messages.addAll(res.messages);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to get messages: $error'),
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
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
            "${chat?.target.username.replaceRange(0, 1, chat!.target.username[0].toUpperCase())}'s"),
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
                          child: Center(
                            child: ListView.builder(
                              shrinkWrap: true,
                              controller: scrollController,
                              itemCount: messages.length,
                              itemBuilder: ((context, index) {
                                Message message = messages[index];
                                final user = userRepository.getUser();
                                bool isOwn =
                                    message.sender.username == user?.username;
                                return isOwn
                                    ? SentMessageScreen(message: message)
                                    : ReceivedMessageScreen(message: message);
                              }),
                            ),
                          ),
                        )
                      : const Center(
                          child: Text(
                              "No message found,start conversion with 'hi' "),
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
                  hintText: 'Писать сюда нельзя (сломается)'),
              onChanged: (value) {
                if (value.isNotEmpty) {}
              },
            ),
          ),
        ],
      ),
    );
  }

  loadingWidget() => const Center(child: CircularProgressIndicator());

  errorWidget() => Center(
      child: Text(error ?? "Something went wrong",
          style: const TextStyle(color: Colors.red)));
}
