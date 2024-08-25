import 'dart:async';
import 'dart:typed_data';

import 'package:board_client/data/repository/chat_repository.dart';
import 'package:board_client/generated/chat.pb.dart';
import 'package:board_client/pages/chats/widget/received_message.dart';
import 'package:board_client/pages/chats/widget/sent_message.dart';
import 'package:board_client/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:fixnum/fixnum.dart' as fnum;
import 'package:go_router/go_router.dart';

import '../../bloc/image_bloc/image_bloc.dart';
import '../../data/repository/ad_repository.dart';
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
  final _imageBloc = ImageBloc(
    GetIt.I<AdRepository>(),
  );

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
    final user = userRepository.getUser();
    final req = SendMessageRequest(
        message: message,
        receiver: user?.id,
        data: Markup.dateNow(),
        chatId: fnum.Int64(widget.chatId));
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
      final res = await chatRepository.getMessages(
          widget.chatId, userRepository.getToken());
      chat = res.chat;
      _imageBloc.add(LoadImageList(chat!.ad.id, true));
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
        title: Text("${chat?.target.username}"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            child: InkWell(
              onTap: () {
                context.push("/ad/${chat?.ad.id}");
              },
              child: SizedBox(
                height: 50,
                child: Padding(
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
                                width: 44,
                                height: 44,
                                fit: BoxFit.fitWidth,
                                Uint8List.fromList(state.images.first),
                              );
                            }
                            if (state is ImageLoadingFailure) {
                              return Container(
                                width: 60,
                                height: 60,
                                color: Colors.black12,
                              );
                            }
                            return const SizedBox(
                                width: 60,
                                height: 60,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          },
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
            ),
          ),
          isLoading
              ? loadingWidget()
              : error != null
                  ? errorWidget()
                  : messages.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            controller: scrollController,
                            itemCount: messages.length,
                            itemBuilder: ((context, index) {
                              Message message =
                                  messages[messages.length - index - 1];
                              final user = userRepository.getUser();
                              return (message.sender.username.toLowerCase() == user?.username.toLowerCase())
                                  ? SentMessageScreen(
                                      message: message,
                                      chatRepository: chatRepository,
                                      token: userRepository.getToken(),
                                    )
                                  : ReceivedMessageScreen(message: message);
                            }),
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

  loadingWidget() => const Center(child: CircularProgressIndicator());

  errorWidget() => Center(
      child: Text(error ?? "Something went wrong",
          style: const TextStyle(color: Colors.red)));
}
