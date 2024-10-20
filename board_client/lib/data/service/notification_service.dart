import 'package:board_client/data/service/user_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class NotificationService {
  final BuildContext context;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationService({required this.context}) {
    _firebaseMessaging.getToken().then((token) {
      GetIt.I<UserService>().initFMC(token);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      context.push("/chat/${message.data["id"]}");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Column(
              children: [
                Text(
                  message.notification!.title!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  message.notification!.body!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }
}
