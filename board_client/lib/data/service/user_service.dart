import 'dart:developer';
import 'package:fixnum/fixnum.dart';

import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/user.pbgrpc.dart';
import '../../values/values.dart';
import '../repository/user_repository.dart';

class UserService implements UserRepository {
  static String? authToken;
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
  Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  User? getUser() => appUser;

  @override
  Future<void> loadUser() async {
    final response = await _client.getUserData(JwtProto(token: authToken));
    appUser = response.user;
  }

  @override
  String? getToken() => authToken;

  @override
  Future<bool> isAuthAvailable() async {
    final sharedPreferences = await getSharedPreferences();
    authToken = sharedPreferences.getString('token');
    log("${authToken}token");
    if (authToken != null) {
      final response = await _client.getUserData(JwtProto(token: authToken));
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
  Future<bool> logout() async {
    final sharedPreferences = await getSharedPreferences();
    authToken = null;
    appUser = null;
    return sharedPreferences.remove('token');
  }

  @override
  Future<bool> login(String username, String password) async {
    try {
      final request = LoginRequest(username: username, password: password);
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
  Future<bool> changeUser(User? user, String? token) async {
    final response =
        await _client.changeUserData(SetUser(user: user, token: token));
    return response.login;
  }

  @override
  Future<User> getUserById(Int64 id) async {
    final user = await _client.getUserById(GetByUserIdRequest(id: id));
    return user.user;
  }
}
