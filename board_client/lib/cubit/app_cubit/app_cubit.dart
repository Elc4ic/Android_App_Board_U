import 'package:bloc/bloc.dart';
import 'package:board_client/data/service/cache_service.dart';
import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

final themeMap = {
  "light": scheme(themeColors()),
  "dark": scheme(darkColors()),
  "beige": scheme(beigeColors()),
};

final themeList = themeMap.keys.toList();

class AppCubit extends Cubit<AppState> {
  late ColorScheme scheme;
  late String theme;

  AppCubit() : super(AppInitial()) {
    String? stringTheme = CacheService.getData(key: 'theme');
    theme = stringTheme ?? "light";
    scheme = themeMap[stringTheme] ?? themeMap["light"]!;
  }

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  void changeAppMode(String change) {
    theme = change;
    scheme = themeMap[change]!;
    CacheService.saveData(key: 'theme', value: change).then((value) {
      emit(AppChangeMode());
    });
  }
}
