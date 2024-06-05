import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/user.pb.dart';

abstract class UserRepository {
  Future<SharedPreferences> getSharedPreferences();

  Future<bool> isAuthAvailable();

  Future<bool> updateToken(String token);

  Future<void> loadUser();

  String? getToken();

  User? getUser();

  Future<bool> logout();

  Future<bool> login(String username, String password);

  Future<bool> signUp(String username, String password, String phone);
}
