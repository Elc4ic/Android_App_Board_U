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
            context.push("${SC.USER_PAGE}/${user.id}");
          },
          child: Row(
            children: [
              Padding(
                padding: Markup.padding_all_8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.memory(
                    gaplessPlayback: true,
                    width: 50,
                    height: 50,
                    fit: BoxFit.fitWidth,
                    Uint8List.fromList(user.avatar),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name,
                      style: Theme.of(context).textTheme.labelMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Markup.countRating(user.ratingAll, user.ratingNum),
                          style: Theme.of(context).textTheme.bodyMedium),
                      const Icon(
                        size: 20,
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MiniProfileButton extends StatelessWidget {
  const MiniProfileButton({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.push("${SC.USER_PAGE}/${user.id}");
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.memory(
                gaplessPlayback: true,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                Uint8List.fromList(user.avatar),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name, style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Padding(
        padding: Markup.padding_all_8,
        child: Column(
          children: [
            Padding(
              padding: Markup.padding_all_16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.memory(
                  gaplessPlayback: true,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitWidth,
                  Uint8List.fromList(user.avatar),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.push("${SC.COMMENT_PAGE}/${user.id}");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Markup.countRating(user.ratingAll, user.ratingNum),
                      style: Theme.of(context).textTheme.titleMedium),
                  const Icon(
                    size: 30,
                    Icons.star,
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
            Text(user.name ?? "-",
                style: Theme.of(context).textTheme.bodyLarge),
            Text(user.address ?? "-",
                style: Theme.of(context).textTheme.bodyMedium),
            Text(user.phone ?? "-",
                style: Theme.of(context).textTheme.bodyMedium),
            Markup.dividerH5,
            const Divider(height: 3),
          ],
        ),
      ),
    );
  }
}
