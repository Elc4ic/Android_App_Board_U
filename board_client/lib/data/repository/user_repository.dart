import 'package:shared_preferences/shared_preferences.dart';
import 'package:fixnum/fixnum.dart';

import '../../generated/user.pb.dart';

abstract class UserRepository {
  Future<SharedPreferences> getSharedPreferences();

  Future<bool> isAuthAvailable();

  Future<bool> updateToken(String token);

  Future<void> loadUser();

  String? getToken();

  User? getUser();

  Future<User> getUserById(Int64 id);

  Future<bool> changeUser(User? user, String? token);

  Future<bool> logout();

  Future<bool> login(String username, String password);

  Future<bool> signUp(String username, String password, String phone);
}
