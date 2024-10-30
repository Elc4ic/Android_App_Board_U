import 'package:board_client/cubit/comment_cubit/comment_cubit.dart';
import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:board_client/pages/settings/comments/comment_row.dart';
import 'package:board_client/widgets/shimerring_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fixnum/fixnum.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/user.pb.dart';
import '../../../values/values.dart';
import '../../../widgets/try_again.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.userId});

  final Int64 userId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  late final _commentBloc = CommentCubit.get(context);

  @override
  void initState() {
    _commentBloc.loadComments(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _commentBloc.loadComments(widget.userId);
          },
          child: BlocConsumer<CommentCubit, CommentState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is CommentsLoaded) {
                if (state.comments.isEmpty) {
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
                  itemCount: state.comments.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return firstInfo(state.user);
                    } else {
                      return CommentRow(
                          comment: state.comments[index - 1],
                          isMine: false,
                          commentBloc: _commentBloc);
                    }
                  },
                );
              }
              if (state is CommentLoadingFailure) {
                return TryAgainWidget(
                  exception: state.exception,
                  onPressed: () {
                    _commentBloc.loadComments(widget.userId);
                  },
                );
              }
              return ShimmeringContainer();
            },
          ),
        ),
      ),
      bottomNavigationBar: (_commentBloc.getUser()?.id != widget.userId)
          ? ElevatedButton(
              onPressed: () {
                context.push("${SC.ADD_COMMENT_PAGE}/${widget.userId}");
              },
              child: Text(SC.PUBLISH_AD,
                  style: Theme.of(context).textTheme.bodyMedium),
            )
          : null,
    );
  }

  Widget firstInfo(User user) {
    return Container(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Markup.countRating(user.ratingAll, user.ratingNum),
              style: Theme.of(context).textTheme.titleLarge),
          RatingBar.builder(
            initialRating: user.ratingAll / user.ratingNum,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (double value) {},
            ignoreGestures: true,
          ),
        ],
      ),
    );
  }
}
