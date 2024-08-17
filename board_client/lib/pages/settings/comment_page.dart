import 'package:board_client/pages/settings/widget/comment_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:fixnum/fixnum.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/user_bloc/user_bloc.dart';
import '../../data/repository/user_repository.dart';
import '../../values/values.dart';
import '../../widgets/widgets.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.userId});

  final Int64 userId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  var userRepository = GetIt.I<UserRepository>();

  final _commentBloc = UserBloc(
    GetIt.I<UserRepository>(),
  );

  @override
  void initState() {
    _commentBloc.add(LoadComments(widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            _commentBloc.add(LoadComments(widget.userId));
          },
          child: BlocBuilder<UserBloc, UserState>(
            bloc: _commentBloc,
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
                return Column(
                  children: [
                    Expanded(
                      child: RatingBar.builder(
                        initialRating:
                            state.user.ratingAll / state.user.ratingNum,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (double value) {},
                      ),
                    ),
                    Text("${state.user.ratingAll}/${state.user.ratingAll}",
                        style: Theme.of(context).textTheme.titleLarge),
                    Markup.dividerH10,
                    ListView.builder(
                      padding: Markup.padding_all_4,
                      itemCount: state.comments.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CommentRow(
                          comment: state.comments[index],
                          token: userRepository.getToken(),
                        );
                      },
                    ),
                  ],
                );
              }
              if (state is UserLoadingFailure) {
                return TryAgainWidget(
                  exception: state.exception,
                  onPressed: () {
                    _commentBloc.add(LoadComments(widget.userId));
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(SC.ADD_COMMENT_PAGE);
        },
        child: Text(SC.PUBLISH_AD, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
