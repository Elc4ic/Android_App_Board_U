import 'package:board_client/cubit/ad_cubit/ad_cubit.dart';
import 'package:board_client/cubit/app_cubit/app_cubit.dart';
import 'package:board_client/cubit/category_cubit/category_cubit.dart';
import 'package:board_client/cubit/chat_bloc/chat_cubit.dart';
import 'package:board_client/cubit/comment_cubit/comment_cubit.dart';
import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:board_client/data/service/ad_service.dart';
import 'package:board_client/data/service/category_service.dart';
import 'package:board_client/data/service/chat_service.dart';
import 'package:board_client/data/service/user_service.dart';
import 'package:board_client/routing/router.dart';
import 'package:board_client/theme.dart';
import 'package:board_client/values/values.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'cubit/ad_list_cubit/ad_list_cubit.dart';
import 'cubit/fav_cubit/fav_cubit.dart';
import 'cubit/my_cubit/my_cubit.dart';
import 'cubit/user_ad_cubit/user_ad_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    print("offline");
    GetIt.I<UserService>().setOffline(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print('Handling a background message: ${message.messageId}');
    });

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AdCubit(GetIt.I<AdService>())),
        BlocProvider(create: (context) => ChatCubit(GetIt.I<ChatService>())),
        BlocProvider(create: (context) => CategoryCubit(GetIt.I<CategoryService>())),
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => UserCubit(GetIt.I<UserService>())),
        BlocProvider(create: (context) => AdListCubit(GetIt.I<AdService>())),
        BlocProvider(create: (context) => MyCubit(GetIt.I<AdService>())),
        BlocProvider(create: (context) => UserAdCubit(GetIt.I<AdService>())),
        BlocProvider(create: (context) => CommentCubit(GetIt.I<UserService>())),
        BlocProvider(create: (context) => FavCubit(GetIt.I<AdService>()))
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: SC.APP_TITLE,
            theme: mainTheme(context),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
