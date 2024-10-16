import 'dart:typed_data';

import 'package:board_client/widgets/black_containers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../generated/user.pb.dart';
import '../values/values.dart';

class MiniProfile extends StatelessWidget {
  const MiniProfile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlackBox(
      padding: Markup.padding_all_8,
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Markup.countRating(user.ratingAll, user.ratingNum),
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium),
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
            child: Image.memory(
              gaplessPlayback: true,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              Uint8List.fromList(user.avatar),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name, style: Theme
                  .of(context)
                  .textTheme
                  .labelMedium),
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
    return Column(
      children: [
        Padding(
          padding: Markup.padding_all_16,
          child: BlackBox(
            child: Image.memory(
              gaplessPlayback: true,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              Uint8List.fromList(user.avatar),
            ),
          ),
        ),
        const Divider(height: 1,),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Text(user.name,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge),
              ),
            ),
            Expanded(
              flex: 2,
              child: LBlackBox(
                child: ElevatedButton(
                  onPressed: () {
                    context.push("${SC.COMMENT_PAGE}/${user.id}");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(Markup.countRating(user.ratingAll, user.ratingNum),
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium),
                      const Icon(
                        size: 30,
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        const Divider(height: 1,),
        Row(
          children: [
            RBlackBox(
              padding: Markup.padding_all_8,
              child: Text("Адрес",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge),
            ),
            Expanded(
              child: Padding(
                padding: Markup.padding_all_8,
                child: Text(user.address ?? "-",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium),
              ),
            )
          ],
        ),
        VerticalBlackBox(
          child: Row(
            children: [
              RBlackBox(
                padding: Markup.padding_all_8,
                child: Text("Телефон",
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge),
              ),
              Expanded(
                child: Padding(
                  padding: Markup.padding_all_8,
                  child: Text(user.phone ?? "-",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
