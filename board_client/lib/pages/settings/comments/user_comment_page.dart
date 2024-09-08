import 'package:board_client/pages/settings/comments/comment_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../bloc/user_bloc/user_bloc.dart';
import '../../../data/repository/user_repository.dart';
import '../../../values/values.dart';
import '../../../widgets/widgets.dart';

class UserCommentPage extends StatefulWidget {
  const UserCommentPage({super.key});

  @override
  State<UserCommentPage> createState() => _UserCommentPageState();
}

class _UserCommentPageState extends State<UserCommentPage> {

  final _commentBloc = UserBloc(
    GetIt.I<UserRepository>(),
  );

  @override
  void initState() {
    _commentBloc.add(LoadUserComments());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _commentBloc.add(LoadUserComments());
          },
          child: BlocBuilder<UserBloc, UserState>(
            bloc: _commentBloc,
            builder: (context, state) {
              if (state is UserCommentsLoaded) {
                if (state.comments.isEmpty) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 100,
                          child: Center(
                            child: Text(SC.SEARCH_NOTHING,
                                style:
                                    Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                      )
                    ],
                  );
                }
                return ListView.builder(
                  padding: Markup.padding_all_4,
                  itemCount: state.comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CommentRow(comment: state.comments[index],isMine: true, userBloc: _commentBloc,);
                  },
                );
              }
              if (state is UserLoadingFailure) {
                return TryAgainWidget(
                  exception: state.exception,
                  onPressed: () {
                    _commentBloc.add(LoadUserComments());
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
