import 'package:board_client/cubit/chat_bloc/chat_cubit.dart';
import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:board_client/pages/chats/widget/chat_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../values/values.dart';
import '../../widgets/widgets.dart';

class ChatsPreviewPage extends StatefulWidget {
  const ChatsPreviewPage({super.key});

  @override
  State<ChatsPreviewPage> createState() => _ChatsPreviewPageState();
}

class _ChatsPreviewPageState extends State<ChatsPreviewPage> {
  late final _chatListBloc = ChatCubit.get(context);
  late final _userBloc = UserCubit.get(context);

  @override
  void initState() {
    _chatListBloc.loadChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Чаты", style: Theme.of(context).textTheme.labelLarge),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _chatListBloc.loadChats();
          },
          child: BlocConsumer<ChatCubit, ChatState>(
            listener: (context, state) {},
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
                  cacheExtent: Const.cacheExtent,
                  itemCount: state.chat.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChatRow(
                      chat: state.chat[index],
                      token: _userBloc.getToken(),
                      chatBloc: _chatListBloc,
                    );
                  },
                );
              }
              if (state is ChatLoadingFailure) {
                return TryAgainWidget(
                  exception: state.exception,
                  onPressed: () {
                    _chatListBloc.loadChats();
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
