import 'package:shared_preferences/shared_preferences.dart';


abstract class UserRepository {
  Future<SharedPreferences> getSharedPreferences();

  Future<bool> isAuthAvailable();

  Future<bool> updateToken(String token);

  String? getToken();

  Future<bool> logout();

  Future<void> login(String username, String password);

  Future<void> signUp(String username, String password, String phone);
}
