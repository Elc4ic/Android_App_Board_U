import 'package:board_client/data/service/cache_service.dart';
import 'package:flutter/services.dart';

import 'package:grpc/grpc.dart';

import '../../generated/user.pbgrpc.dart';
import '../../values/values.dart';

class UserService {
  static String? _authToken;
  static String? _fmcToken;
  static User? _appUser;
  late UserAPIClient _client;

  User? getUser() => _appUser;

  String? getToken() => _authToken;

  String? getFCMToken() => _fmcToken;

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
    _authToken = CacheService.getData(key: 'token');
    initClient();
    try {
      final response = await _client.getUserAndRefresh(Empty());
      initClient();
      _authToken = response.token;
      CacheService.saveData(key: 'token', value: response.token);
      _appUser = response.user;
      return _authToken;
    } catch (e) {
      return _authToken;
    }
  }

  Future<bool> updateAvatar(Uint8List avatar) async {
    final response = await _client.setAvatar(ImageProto(chunk: avatar));
    return response.login;
  }

  Future<bool> updateUser() async {
    _appUser = await _client.getUserById(Id(id: _appUser?.id));
    return true;
  }

  Future<bool> logout() async {
    await _client.logOut(Empty());
    _authToken = null;
    _appUser = User.getDefault();
    return CacheService.removeData(key: 'token');
  }

  Future<String> login(String username, String password) async {
    try {
      final request = LoginRequest(
        username: username,
        password: password,
        deviceToken: _fmcToken,
      );
      final response = await _client.getLogin(request);
      await updateToken(response.accessToken);
      _appUser = response.user;
      return response.accessToken;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateToken(String token) async {
    _authToken = token;
    initClient();
    return CacheService.saveData(key: 'token', value: token);
  }

  Future<String> signUp(String username, String password, String phone) async {
    try {
      Id response = await _client.startSignUp(
        User(username: username, password: password, phone: phone),
      );
      return response.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> endIfPhoneValid(String id, String code) async {
    try {
      await _client.endSignUp(Code(id: id, code: code));
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> changeUser(User user) async {
    final response = await _client.changeUserData(user);
    return response.login;
  }

  Future<bool> deleteUser() async {
    var response = await _client.deleteUser(Empty());
    return response.login;
  }

  Future<bool> setAvatar(ImageProto image) async {
    final response = await _client.setAvatar(image);
    return response.login;
  }

  Future<User> getUserById(String id) async {
    final user = await _client.getUserById(Id(id: id));
    return user;
  }

  Future<bool> addComment(Comment comment) async {
    final response = await _client.addComment(comment);
    return response.login;
  }

  Future<bool> deleteComment(String id) async {
    final response = await _client.deleteComment(Id(id: id));
    return response.login;
  }

  Future<bool> setOffline(bool online) async {
    final response = await _client.setOffline(IsSuccess(login: online));
    return response.login;
  }

  Future<List<Comment>> getComments(String id) async {
    final comments = await _client.getComments(Id(id: id));
    return comments.comments;
  }

  Future<List<Comment>> getUserComments() async {
    final comments = await _client.getUserComments(Empty());
    return comments.comments;
  }

  void initFMC(String? token) {
    _fmcToken = token;
  }
}
