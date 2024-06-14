import 'package:board_client/generated/ad.pb.dart';
import 'package:board_client/pages/chats/widget/chat_row.dart';
import 'package:board_client/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:fixnum/fixnum.dart' as fnum;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../bloc/chat_bloc/chat_bloc.dart';
import '../../data/repository/chat_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../values/values.dart';
import '../../widgets/footers/navigation_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            child: Styles.Text16(SC.SEARCH_NOTHING),
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
