
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository/user_repository.dart';
import '../../generated/user.pb.dart';
import '../../values/values.dart';
import '../../widgets/footers/navigation_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final userRepository = GetIt.I<UserRepository>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 400,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Styles.Text16("${userRepository.getToken()} token"),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
