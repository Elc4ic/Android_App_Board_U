import 'package:fixnum/fixnum.dart';

import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/user.pbgrpc.dart';
import '../../values/values.dart';

class UserService {
  static String? authToken;
  static String? fmcToken;
  late UserAPIClient _client;
  static User? appUser;

  UserService() {
    final channel = ClientChannel(
      Const.HOST,
      port: Const.PORT,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _client = UserAPIClient(
      channel,
      options: CallOptions(metadata: {'token': authToken ?? ""}),
    );
  }

  User? getUser() => appUser;

  String? getToken() => authToken;

  String? getFCMToken() => fmcToken;

  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<String?> loadUserAndCheckRefresh() async {
    final sharedPreferences = await getSharedPreferences();
    authToken = sharedPreferences.getString('token');
    if (authToken != null) {
      final response =
          await _client.getUserAndRefresh(JwtProto(token: authToken));
      authToken = response.token;
      sharedPreferences.setString('token', response.token);
      appUser = response.user;
      return authToken;
    }
    return null;
  }

  Future<bool> updateToken(String token) async {
    final sharedPreferences = await getSharedPreferences();
    authToken = token;
    return sharedPreferences.setString('token', token);
  }

  Future<bool> logout(Int64 id) async {
    await _client.logOut(UserId(id: id));
    final sharedPreferences = await getSharedPreferences();
    authToken = null;
    appUser = null;
    return sharedPreferences.remove('token');
  }

  Future<bool> login(String username, String password) async {
    try {
      final request = LoginRequest(
          username: username, password: password, deviceToken: fmcToken);
      final response = await _client.getLogin(request);
      await updateToken(response.accessToken);
      appUser = response.user;
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> signUp(String username, String password, String phone) async {
    try {
      final request =
          SignupRequest(username: username, password: password, phone: phone);
      await _client.getSignUp(request);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> changeUser(User? user) async {
    final response =
        await _client.changeUserData(UserToken(user: user, token: authToken));
    return response.login;
  }

  Future<User> getUserById(Int64 id) async {
    final user = await _client.getUserById(UserId(id: id));
    return user.user;
  }

  Future<bool> addComment(Comment comment) async {
    final response = await _client
        .addComment(CommentProto(comment: comment, token: authToken));
    return response.login;
  }

  Future<bool> editComment(Comment comment, int rating_prev) async {
    final response = await _client.editComment(EditCommentRequest(
        comment: comment, ratingPrev: rating_prev, token: authToken));
    return response.login;
  }

  Future<bool> deleteComment(Int64 id) async {
    final response =
        await _client.deleteComment(IdToken(id: id, token: authToken));
    return response.login;
  }

  Future<List<Comment>> getComments(Int64 id) async {
    final comments = await _client.getComments(UserId(id: id));
    return comments.comments;
  }

  Future<List<Comment>> getUserComments() async {
    final comments = await _client.getUserComments(JwtProto(token: authToken));
    return comments.comments;
  }

  void initFMC(String? token) {
    fmcToken = token;
  }

  Future<bool> deleteUser() async {
    var response = await _client.deleteUser(JwtProto(token: authToken));
    return response.login;
  }
}
