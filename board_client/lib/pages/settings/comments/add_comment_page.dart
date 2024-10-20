import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late final _userBloc = UserCubit.get(context);

  @override
  void initState() {
    _userBloc.initId(widget.convictedId);
    _userBloc.loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is UserLoaded) {
              return CommentForm(user: state.user);
            }
            if (state is UserLoadingFailure) {
              return TryAgainWidget(
                exception: state.exception,
                onPressed: () {
                  _userBloc.loadUser();
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
