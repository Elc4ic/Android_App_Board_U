import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';

class ServicePanel extends StatelessWidget {
  const ServicePanel(
      {super.key,
      required this.onTap,
      required this.title,
      required this.icon});

  final Function() onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: Markup.padding_all_8,
          child: Row(children: [
            Icon(icon,size:30),
            Text("  $title", style: Theme.of(context).textTheme.bodyMedium),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 12)
          ]),
        ),
      ),
    );
  }
}
