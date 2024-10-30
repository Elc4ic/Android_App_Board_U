import 'package:fixnum/fixnum.dart';

import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/user.pbgrpc.dart';
import '../../values/values.dart';

class UserService {
  static String? _authToken;
  static String? _fmcToken;
  late UserAPIClient _client;
  static User? _appUser;

  User? getUser() => _appUser;

  String? getToken() => _authToken;

  String? getFCMToken() => _fmcToken;

  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  void initClient() {
    final channel = ClientChannel(
      Const.HOST,
      port: Const.PORT,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _client = UserAPIClient(
      channel,
      options: CallOptions(metadata: {'token': _authToken ?? ""}),
    );
  }

  Future<String?> loadUserAndCheckRefresh() async {
    final sharedPreferences = await getSharedPreferences();
    _authToken = sharedPreferences.getString('token');
    initClient();
    try {
      final response =
          await _client.getUserAndRefresh(Empty());
      _authToken = response.token;
      sharedPreferences.setString('token', response.token);
      _appUser = response.user;
      return _authToken;
    } catch (e) {
      return _authToken;
    }
  }

  Future<bool> updateToken(String token) async {
    final sharedPreferences = await getSharedPreferences();
    _authToken = token;
    initClient();
    return sharedPreferences.setString('token', token);
  }

  Future<bool> logout(Int64 id) async {
    await _client.logOut(UserId(id: id));
    final sharedPreferences = await getSharedPreferences();
    _authToken = null;
    _appUser = null;
    return sharedPreferences.remove('token');
  }

  Future<bool> login(String username, String password) async {
    try {
      final request = LoginRequest(
          username: username, password: password, deviceToken: _fmcToken);
      final response = await _client.getLogin(request);
      await updateToken(response.accessToken);
      _appUser = response.user;
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signUp(String username, String password, String phone) async {
    try {
      final request =
          SignupRequest(username: username, password: password, phone: phone);
      await _client.getSignUp(request);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> changeUser(User? user) async {
    final response =
        await _client.changeUserData(UserToken(user: user, token: _authToken));
    return response.login;
  }

  Future<User> getUserById(Int64 id) async {
    final user = await _client.getUserById(UserId(id: id));
    return user.user;
  }

  Future<bool> addComment(Comment comment) async {
    final response = await _client
        .addComment(CommentProto(comment: comment));
    return response.login;
  }

  Future<bool> editComment(Comment comment, int rating_prev) async {
    final response = await _client.editComment(EditCommentRequest(
        comment: comment, ratingPrev: rating_prev));
    return response.login;
  }

  Future<bool> deleteComment(Int64 id) async {
    final response =
        await _client.deleteComment(Id(id: id));
    return response.login;
  }

  Future<List<Comment>> getComments(Int64 id) async {
    final comments = await _client.getComments(UserId(id: id));
    return comments.comments;
  }

  Future<List<Comment>> getUserComments() async {
    final comments = await _client.getUserComments(Empty());
    return comments.comments;
  }

  void initFMC(String? token) {
    _fmcToken = token;
  }

  Future<bool> deleteUser() async {
    var response = await _client.deleteUser(Empty());
    return response.login;
  }
}
