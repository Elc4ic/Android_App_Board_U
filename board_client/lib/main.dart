import 'package:board_client/data/repository/category_repository.dart';
import 'package:board_client/data/service/ad_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app.dart';
import 'data/repository/ad_repository.dart';
import 'data/repository/user_repository.dart';
import 'data/repository/chat_repository.dart';
import 'data/service/category_service.dart';
import 'data/service/notification_service.dart';
import 'data/service/user_service.dart';
import 'data/service/chat_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerLazySingleton<AdRepository>(() => AdService());
  GetIt.I.registerLazySingleton<UserRepository>(() => UserService());
  GetIt.I.registerLazySingleton<CategoryRepository>(() => CategoryService());
  GetIt.I.registerLazySingleton<ChatRepository>(() => ChatService());

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCI49VuAK1DU-I89OB17OHCqN-FdgkZPYw',
      appId: '1:561159980944:android:39b16a95acd0bfd9165515',
      messagingSenderId: '561159980944',
      projectId: 'dvfu-board',
      storageBucket: 'dvfu-board.appspot.com',
    ),
  );

  NotificationService();

  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
  });

  runApp(const MyApp());
}
