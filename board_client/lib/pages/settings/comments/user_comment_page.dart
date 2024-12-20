import 'package:board_client/cubit/comment_cubit/comment_cubit.dart';
import 'package:board_client/pages/settings/comments/comment_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../values/values.dart';
import '../../../widgets/try_again.dart';

class UserCommentPage extends StatefulWidget {
  const UserCommentPage({super.key});

  @override
  State<UserCommentPage> createState() => _UserCommentPageState();
}

class _UserCommentPageState extends State<UserCommentPage> {

  late final _commentBloc = CommentCubit.get(context);

  @override
  void initState() {
    _commentBloc.loadUserComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _commentBloc.loadUserComments();
          },
          child: BlocConsumer<CommentCubit, CommentState>(
            listener:  (context, state) {},
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
                  itemCount: state.comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CommentRow(comment: state.comments[index],isMine: true, commentBloc: _commentBloc);
                  },
                );
              }
              if (state is CommentLoadingFailure) {
                return TryAgainWidget(
                  exception: state.exception,
                  onPressed: () {
                    _commentBloc.loadUserComments();
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
