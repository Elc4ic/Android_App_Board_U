import 'package:board_client/cubit/observer.dart';
import 'package:board_client/data/service/ad_service.dart';
import 'package:board_client/data/service/cache_service.dart';
import 'package:board_client/data/service/session_service.dart';
import 'package:board_client/generated/session.pb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:firebase_core/firebase_core.dart';

import 'app.dart';
import 'data/service/category_service.dart';
import 'data/service/user_service.dart';
import 'data/service/chat_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = LogBlocObserver();
  await CacheService.init();

  GetIt.I.registerLazySingleton(() => UserService());
  GetIt.I.registerLazySingleton(() => AdService());
  GetIt.I.registerLazySingleton(() => CategoryService());
  GetIt.I.registerLazySingleton(() => ChatService());
  GetIt.I.registerLazySingleton(() => SessionService());

  var token = await GetIt.I<UserService>().loadUserAndCheckRefresh();
  GetIt.I<AdService>().initClient(token);
  GetIt.I<SessionService>().initClient(token);
  GetIt.I<CategoryService>().initClient(token);
  GetIt.I<ChatService>().initClient(token);

  GetIt.I<SessionService>().registerSession();
  GetIt.I<SessionService>().getSessionAlive();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCI49VuAK1DU-I89OB17OHCqN-FdgkZPYw',
      appId: '1:561159980944:android:39b16a95acd0bfd9165515',
      messagingSenderId: '561159980944',
      projectId: 'dvfu-board',
      storageBucket: 'dvfu-board.appspot.com',
    ),
  );
  runApp(const MyApp());
}
