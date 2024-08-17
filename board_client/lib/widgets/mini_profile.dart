import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../generated/user.pb.dart';
import '../values/values.dart';

class MiniProfile extends StatelessWidget {
  const MiniProfile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: Markup.padding_all_8,
        width: double.infinity,
        child: InkWell(
          onTap: () {
            context.push(
                "${SC.USER_PAGE}/${user.id}");
          },
          child: Row(
            children: [
              Padding(
                padding: Markup.padding_all_8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.memory(
                    width: 50,
                    height: 50,
                    fit: BoxFit.fitWidth,
                    Uint8List.fromList(user.avatar),
                  ),
                ),
              ),
              Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                        user.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium),
                    Text(user.address,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
