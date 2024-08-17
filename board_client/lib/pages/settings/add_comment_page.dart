import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository/user_repository.dart';
import '../../generated/user.pb.dart';
import '../../widgets/form/comment_form.dart';

class AddCommentPage extends StatefulWidget {
  const AddCommentPage({super.key});

  @override
  State<AddCommentPage> createState() => _AddCommentPageState();
}

class _AddCommentPageState extends State<AddCommentPage> {
  final userRepository = GetIt.I<UserRepository>();

  @override
  Widget build(BuildContext context) {
    User? user = userRepository.getUser();
    return Scaffold(
      body: SafeArea(
        child: CommentForm(user: user),
      ),
    );
  }
}
