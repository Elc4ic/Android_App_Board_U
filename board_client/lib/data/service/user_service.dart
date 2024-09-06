import 'dart:developer';
import 'package:fixnum/fixnum.dart';

import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/user.pbgrpc.dart';
import '../../values/values.dart';
import '../repository/user_repository.dart';

class UserService implements UserRepository {
  static String? authToken;
  static String? fmcToken;
  static User? appUser;
  late UserAPIClient _client;

  UserService() {
    final channel = ClientChannel(
      Const.HOST,
      port: Const.PORT,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _client = UserAPIClient(channel);
  }

  @override
  User? getUser() => appUser;

  @override
  String? getToken() => authToken;

  @override
  String? getFCMToken() => fmcToken;

  @override
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<bool> loadUserAndCheckRefresh() async {
    final sharedPreferences = await getSharedPreferences();
    authToken = sharedPreferences.getString('token');
    print(authToken);
    if (authToken != null) {
      final response =
          await _client.getUserAndRefresh(JwtProto(token: authToken));
      authToken = response.token;
      print(authToken);
      sharedPreferences.setString('token', response.token);
      appUser = response.user;
      return true;
    }
    return false;
  }

  @override
  Future<bool> updateToken(String token) async {
    final sharedPreferences = await getSharedPreferences();
    authToken = token;
    return sharedPreferences.setString('token', token);
  }

  @override
  Future<bool> logout(Int64 id) async {
    await _client.logOut(UserId(id: id));
    final sharedPreferences = await getSharedPreferences();
    authToken = null;
    appUser = null;
    return sharedPreferences.remove('token');
  }

  @override
  Future<bool> login(String username, String password) async {
    try {
      final request = LoginRequest(
          username: username, password: password, deviceToken: fmcToken);
      final response = await _client.getLogin(request);
      log(response.accessToken);
      await updateToken(response.accessToken);
      appUser = response.user;
      return true;
    } catch (e) {
      log("$e my login error");
      return false;
    }
  }

  @override
  Future<bool> signUp(String username, String password, String phone) async {
    try {
      final request =
          SignupRequest(username: username, password: password, phone: phone);
      await _client.getSignUp(request);
      return true;
    } catch (e) {
      log("$e my signUp error");
      return false;
    }
  }

  @override
  Future<bool> changeUser(User? user) async {
    final response =
        await _client.changeUserData(UserToken(user: user, token: authToken));
    return response.login;
  }

  @override
  Future<User> getUserById(Int64 id) async {
    final user = await _client.getUserById(UserId(id: id));
    return user.user;
  }

  @override
  Future<bool> addComment(Comment comment) async {
    final response = await _client
        .addComment(CommentProto(comment: comment, token: authToken));
    return response.login;
  }

  @override
  Future<bool> editComment(Comment comment, int rating_prev) async {
    final response = await _client.editComment(EditCommentRequest(
        comment: comment, ratingPrev: rating_prev, token: authToken));
    return response.login;
  }

  @override
  Future<bool> deleteComment(Int64 id) async {
    final response =
        await _client.deleteComment(IdToken(id: id, token: authToken));
    return response.login;
  }

  @override
  Future<List<Comment>> getComments(Int64 id) async {
    final comments = await _client.getComments(UserId(id: id));
    return comments.comments;
  }

  @override
  Future<List<Comment>> getUserComments() async {
    final comments = await _client.getUserComments(JwtProto(token: authToken));
    return comments.comments;
  }

  @override
  void initFMC(String? token) {
    fmcToken = token;
  }
}
