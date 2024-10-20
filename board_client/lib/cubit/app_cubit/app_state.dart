part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppChangeBottomNavBar extends AppState {}

class AppCreateDatabase extends AppState {}

class AppGetDatabaseLoading extends AppState {}

class AppGetDatabase extends AppState {}

class AppInsertDatabase extends AppState {}

class AppUpdateDatabase extends AppState {}

class AppDeleteDatabase extends AppState {}

class AppChangeBottomSheet extends AppState {}

class AppChangeMode extends AppState {}
