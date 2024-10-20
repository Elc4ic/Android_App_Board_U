import 'package:board_client/cubit/observer.dart';
import 'package:board_client/data/service/ad_service.dart';
import 'package:board_client/data/service/cache_service.dart';
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
  bool? isDark = CacheService.getData(key: 'isDark');

  GetIt.I.registerLazySingleton(() => UserService());

  var token = await GetIt.I<UserService>().loadUserAndCheckRefresh();

  GetIt.I.registerLazySingleton(() => AdService(token));
  GetIt.I.registerLazySingleton(() => CategoryService(token));
  GetIt.I.registerLazySingleton(() => ChatService(token));

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCI49VuAK1DU-I89OB17OHCqN-FdgkZPYw',
      appId: '1:561159980944:android:39b16a95acd0bfd9165515',
      messagingSenderId: '561159980944',
      projectId: 'dvfu-board',
      storageBucket: 'dvfu-board.appspot.com',
    ),
  );

  runApp(MyApp(isDark: isDark));
}
