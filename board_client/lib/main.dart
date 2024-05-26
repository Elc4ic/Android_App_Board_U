import 'package:board_client/data/repository/category_repository.dart';
import 'package:board_client/data/service/ad_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app.dart';
import 'data/repository/ad_repository.dart';
import 'data/repository/user_repository.dart';
import 'data/service/category_service.dart';
import 'data/service/user_service.dart';

void main() {
  GetIt.I.registerLazySingleton<AdRepository>(() => AdService());
  GetIt.I.registerLazySingleton<UserRepository>(() => UserService());
  GetIt.I.registerLazySingleton<CategoryRepository>(() => CategoryService());

  GetIt.I<UserRepository>().isAuthAvailable();

  runApp(const MyApp());
}
