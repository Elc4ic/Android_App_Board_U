import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

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
    final user = userRepository.getUser();
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Styles.Text16("${user?.username}"),
                  Markup.dividerW5,
                  Styles.Text16("${user?.phone}"),
                  Markup.dividerW5,
                  Styles.Text16("${user?.address}"),
                  Markup.dividerW5,
                  Styles.Text16("${userRepository.getToken()} token"),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  userRepository.logout();
                },
                child: Styles.Text16("logout"),
              ),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  context.push("/setaddress");
                },
                child: Styles.Text16("Настроить адресс"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
