import 'package:bloc/bloc.dart';
import 'package:board_client/data/service/cache_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  bool? isDark = true;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeMode());
    } else {
      isDark = !isDark!;
      CacheService.putBoolean(key: 'isDark', value: isDark!).then((value) {
        emit(AppChangeMode());
      });
    }
  }
}
