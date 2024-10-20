import 'package:board_client/cubit/ad_cubit/ad_cubit.dart';
import 'package:board_client/cubit/ad_list_cubit/ad_list_cubit.dart';
import 'package:board_client/cubit/app_cubit/app_cubit.dart';
import 'package:board_client/cubit/category_cubit/category_cubit.dart';
import 'package:board_client/cubit/chat_bloc/chat_cubit.dart';
import 'package:board_client/cubit/image_cubit/image_cubit.dart';
import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:board_client/data/service/ad_service.dart';
import 'package:board_client/data/service/category_service.dart';
import 'package:board_client/data/service/chat_service.dart';
import 'package:board_client/data/service/notification_service.dart';
import 'package:board_client/data/service/user_service.dart';
import 'package:board_client/routing/router.dart';
import 'package:board_client/theme.dart';
import 'package:board_client/values/values.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.isDark});

  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    NotificationService(context: context);

    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print('Handling a background message: ${message.messageId}');
    });

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AdCubit(GetIt.I<AdService>())),
        BlocProvider(
            create: (context) =>
                AdListCubit(GetIt.I<AdService>(), GetIt.I<UserService>())),
        BlocProvider(
            create: (context) =>
                ChatCubit(GetIt.I<ChatService>(), GetIt.I<UserService>())),
        BlocProvider(
            create: (context) => CategoryCubit(GetIt.I<CategoryService>())),
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => ImageCubit(GetIt.I<AdService>())),
        BlocProvider(create: (context) => UserCubit(GetIt.I<UserService>()))
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: SC.APP_TITLE,
            themeMode: AppCubit.get(context).isDark!
                ? ThemeMode.dark
                : ThemeMode.light,
            darkTheme: mainTheme(context),
            theme: mainTheme(context),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
