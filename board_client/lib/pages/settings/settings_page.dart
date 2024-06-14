import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../data/repository/user_repository.dart';
import '../../values/values.dart';

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
                  Styles.Text16("Логин: ${user?.username}"),
                  Markup.dividerW5,
                  Styles.Text16("Телефон: ${user?.phone}"),
                  Markup.dividerW5,
                  Styles.Text16("Адресс: ${user?.address}"),
                ],
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
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  userRepository.logout();
                },
                child: Styles.Text16("logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
