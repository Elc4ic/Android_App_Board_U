import 'dart:typed_data';

import 'package:board_client/widgets/buttons/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../generated/user.pb.dart';
import '../values/values.dart';

class MiniProfile extends StatelessWidget {
  const MiniProfile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Text(user.name, style: Theme.of(context).textTheme.labelMedium),
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
                width: 50,
                height: 50,
                cacheWidth: Const.miniProfileWidth,
                cacheHeight: Const.miniProfileHeight,
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
  const Profile(
      {super.key, required this.user, required this.child,required this.own, });

  final bool own;
  final Widget? child;
  final User user;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var off = 6;
    return Stack(
      children: [
        Container(
          height: height / 2,
          color: Theme.of(context).colorScheme.primary,
        ),
        Container(
          margin: EdgeInsets.only(top: height / off),
          child: ClipRRect(
            borderRadius: Markup.clip_t_20,
            child: Container(
              padding: EdgeInsets.only(top: 80),
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  Text(user.name, style: Theme.of(context).textTheme.bodyLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        size: 20,
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(Markup.countRating(user.ratingAll, user.ratingNum),
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  Card(
                    child: Padding(
                      padding: Markup.padding_all_16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Общая информация",
                              style: Theme.of(context).textTheme.titleSmall),
                          Row(
                            children: [
                              Container(
                                padding: Markup.padding_all_8,
                                child: Text("Адрес",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: Markup.padding_all_8,
                                  child: Text(user.address ?? "-",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                padding: Markup.padding_all_8,
                                child: Text("Телефон",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: Markup.padding_all_8,
                                  child: Text(user.phone ?? "-",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: own,
                    child: Card(
                      child: Padding(
                        padding: Markup.padding_all_16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Приватная информация",
                                style: Theme.of(context).textTheme.titleSmall),
                            Row(
                              children: [
                                Container(
                                  padding: Markup.padding_all_8,
                                  child: Text("Логин",
                                      style:
                                      Theme.of(context).textTheme.bodyMedium),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: Markup.padding_all_8,
                                    child: Text(user.username ?? "-",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: Markup.padding_all_8,
                                  child: Text("Почта",
                                      style:
                                      Theme.of(context).textTheme.bodyMedium),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: Markup.padding_all_8,
                                    child: Text(user.email ?? "-",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  child ?? const SizedBox(height: 0),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: own,
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: height / off + 20, right: 20),
              child: ThemeButton(),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height / off - 60),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.memory(
                gaplessPlayback: true,
                width: 120,
                height: 120,
                cacheWidth: Const.ImageWidth,
                cacheHeight: Const.ImageHeight,
                fit: BoxFit.cover,
                Uint8List.fromList(user.avatar),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
