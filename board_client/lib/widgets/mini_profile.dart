import 'dart:ffi';
import 'dart:typed_data';

import 'package:board_client/data/service/session_service.dart';
import 'package:board_client/widgets/buttons/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../generated/user.pb.dart';
import '../values/values.dart';

class MiniProfile extends StatefulWidget {
  const MiniProfile({super.key, required this.user, required this.online});

  final User user;
  final bool online;

  @override
  State<MiniProfile> createState() => _MiniProfileState();
}

class _MiniProfileState extends State<MiniProfile> {
  @override
  void dispose() {
    GetIt.I<SessionService>().removeSubscribeUser(widget.user.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Markup.padding_all_8,
      child: InkWell(
        onTap: () {
          context.push("${SC.USER_PAGE}/${widget.user.id}");
        },
        child: Row(
          children: [
            Padding(
              padding: Markup.padding_all_8,
              child: OnlineCircle(
                online: widget.online,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    gaplessPlayback: true,
                    width: 50,
                    height: 50,
                    fit: BoxFit.fitWidth,
                    "${Const.image_avatar_api}${widget.user.id}",
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.user.name,
                    style: Theme.of(context).textTheme.labelMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.user.rating.toString(),
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
              child: Image.network(
                gaplessPlayback: true,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                "${Const.image_avatar_api}${user.id}",
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

class Profile extends StatefulWidget {
  const Profile({
    super.key,
    required this.user,
    required this.child,
    required this.own,
    required this.online,
  });

  final bool own;
  final Widget? child;
  final User user;
  final bool online;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void dispose() {
    GetIt.I<SessionService>().removeSubscribeUser(widget.user.id);
    super.dispose();
  }

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
                  Text(widget.user.name,
                      style: Theme.of(context).textTheme.bodyLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        size: 20,
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(widget.user.rating.toString(),
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  Card(
                    child: Container(
                      width: double.infinity,
                      padding: Markup.padding_all_16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Общая информация",
                              style: Theme.of(context).textTheme.titleSmall),
                          Container(
                            padding: Markup.padding_all_8,
                            child: Text("Адрес: ${widget.user.address}",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                          Container(
                            padding: Markup.padding_all_8,
                            child: Text("Телефон: ${widget.user.phone}",
                                style: Theme.of(context).textTheme.bodyMedium),
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.own,
                    child: Card(
                      child: Container(
                        width: double.infinity,
                        padding: Markup.padding_all_16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Приватная информация",
                                style: Theme.of(context).textTheme.titleSmall),
                            Container(
                              padding: Markup.padding_all_8,
                              child: Text("Логин: ${widget.user.username}",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
                            Container(
                              padding: Markup.padding_all_8,
                              child: Text("Почта: ${widget.user.email}",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  widget.child ?? const SizedBox(height: 0),
                  Markup.dividerH10,
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.own,
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: height / off + 20, right: 20),
              child: ThemeButton(),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height / off - 74),
          child: Center(
            child: OnlineCircle(
              online: widget.online,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(74),
                child: Image.network(
                    gaplessPlayback: true,
                    width: 148,
                    height: 148,
                    cacheWidth: Const.ImageWidth,
                    cacheHeight: Const.ImageHeight,
                    fit: BoxFit.cover,
                    "${Const.image_avatar_api}${widget.user.id}"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OnlineCircle extends StatelessWidget {
  const OnlineCircle({super.key, required this.online, required this.child});

  final bool online;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return !online
        ? child
        : Badge(alignment: Alignment.bottomRight, child: child);
  }
}
