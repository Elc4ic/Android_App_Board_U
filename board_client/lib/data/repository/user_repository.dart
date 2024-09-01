import 'package:shared_preferences/shared_preferences.dart';
import 'package:fixnum/fixnum.dart';

import '../../generated/user.pb.dart';

abstract class UserRepository {
  Future<SharedPreferences> getSharedPreferences();

  Future<bool> isAuthAvailable();

  void initFMC(String? token);

  Future<bool> updateToken(String token);

  Future<void> loadUser();

  String? getToken();

  String? getFCMToken();

  User? getUser();

  Future<User> getUserById(Int64 id);

  Future<bool> changeUser(User? user);

  Future<bool> logout();

  Future<bool> login(String username, String password);

  Future<bool> signUp(String username, String password, String phone);

  Future<bool> addComment(Comment comment);

  Future<bool> editComment(Comment comment,int rating_prev);

  Future<bool> deleteComment(Int64 id);

  Future<List<Comment>> getComments(Int64 id);

  Future<List<Comment>> getUserComments();
}
