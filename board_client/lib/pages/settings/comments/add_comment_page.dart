import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../bloc/user_bloc/user_bloc.dart';
import '../../../data/repository/user_repository.dart';
import '../../../widgets/form/comment_form.dart';
import 'package:fixnum/fixnum.dart';

import '../../../widgets/widgets.dart';

class AddCommentPage extends StatefulWidget {
  const AddCommentPage({super.key, required this.convictedId});

  final Int64 convictedId;

  @override
  State<AddCommentPage> createState() => _AddCommentPageState();
}

class _AddCommentPageState extends State<AddCommentPage> {

  final _userBloc = UserBloc(
    GetIt.I<UserRepository>(),
  );

  @override
  void initState() {
    _userBloc.add(LoadUser(widget.convictedId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserBloc, UserState>(
          bloc: _userBloc,
          builder: (context, state) {
            if (state is UserLoaded) {
              return CommentForm(user: state.user);
            }
            if (state is UserLoadingFailure) {
              return TryAgainWidget(
                exception: state.exception,
                onPressed: () {
                  _userBloc.add(LoadUser(widget.convictedId));
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
