import 'dart:developer';

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

  String? getToken() => authToken;

  @override
  Future<bool> isAuthAvailable() async {
    final sharedPreferences = await getSharedPreferences();
    authToken = sharedPreferences.getString('token');
    return authToken != null;
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
  void login(String username, String password) async {
    try {
      final request =
          LoginRequestMessage(username: username, password: password);
      final response = await _client.login(request);
      await updateToken(response.accessToken);
      appUser = response.user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<User> signup(String username, String password, String phone) async {
    try {
      final request = SignupRequestMessage(
          username: username, password: password, phone: phone);
      final response = await _client.signUp(request);
      return response.user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
