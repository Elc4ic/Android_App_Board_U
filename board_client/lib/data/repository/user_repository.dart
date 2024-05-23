import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/user.pb.dart';

abstract class UserRepository {
  Future<SharedPreferences> getSharedPreferences();

  Future<bool> isAuthAvailable();

  Future<bool> updateToken(String token);

  User? getUser();

  Future<bool> logout();

  void login(String username, String password);

  Future<User> signup(String username, String password, String name);
}
