
import 'package:flutter/material.dart';

import '../../generated/user.pb.dart';
import '../../values/values.dart';
import '../../widgets/footers/navigation_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key,required this.user});

  final User user;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                  Styles.Text16(widget.user.username),
                  Styles.Text16(widget.user.email),
                  Styles.Text16(widget.user.address),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
