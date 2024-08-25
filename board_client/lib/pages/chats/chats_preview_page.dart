import 'package:board_client/pages/chats/widget/chat_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/chat_bloc/chat_bloc.dart';
import '../../data/repository/chat_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../values/values.dart';
import '../../widgets/widgets.dart';

class ChatsPreviewPage extends StatefulWidget {
  const ChatsPreviewPage({super.key});

  @override
  State<ChatsPreviewPage> createState() => _ChatsPreviewPageState();
}

class _ChatsPreviewPageState extends State<ChatsPreviewPage> {
  final _chatListBloc = ChatBloc(
    GetIt.I<ChatRepository>(),
    GetIt.I<UserRepository>(),
  );

  @override
  void initState() {
    _chatListBloc.add(LoadChatList());
    super.initState();
  }

  final userRepository = GetIt.I<UserRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Чаты",
            style: Theme.of(context).textTheme.labelLarge),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _chatListBloc.add(LoadChatList());
          },
          child: BlocBuilder<ChatBloc, ChatState>(
            bloc: _chatListBloc,
            builder: (context, state) {
              if (state is ChatLoaded) {
                if (state.chat.isEmpty) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(SC.SEARCH_NOTHING,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                      )
                    ],
                  );
                }
                return ListView.builder(
                  padding: Markup.padding_all_4,
                  itemCount: state.chat.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChatRow(
                      chat: state.chat[index],
                      token: userRepository.getToken(),
                      chatBloc: _chatListBloc,
                    );
                  },
                );
              }
              if (state is ChatLoadingFailure) {
                return TryAgainWidget(
                  exception: state.exception,
                  onPressed: () {
                    _chatListBloc.add(LoadChatList());
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
