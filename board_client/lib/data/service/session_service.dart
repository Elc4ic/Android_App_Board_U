import 'dart:async';

import 'package:grpc/grpc.dart';

import '../../generated/session.pbgrpc.dart';
import '../../values/values.dart';

class SessionService {
  late SessionAPIClient _client;
  final StreamController<EnterRequest> myOnlineController =
      StreamController<EnterRequest>();
  final StreamController<SubscribeRequest> subscribeController =
      StreamController<SubscribeRequest>();
  final List<String> _subscribeUsers = [];
  final Map<String, bool> _onlineUsers = {};

  void initClient(String? token) {
    final channel = ClientChannel(
      Const.HOST,
      port: Const.PORT,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _client = SessionAPIClient(
      channel,
      options: CallOptions(metadata: {'token': token ?? ""}),
    );
    if (token != null) {
      registerSession();
      getSessionAlive();
      updateBySubscribe();
      initSubscribeStream();
    }
  }

  void registerSession() {
    final request = myOnlineController.stream;
    var stream = _client.registerSession(request);
    stream.listen((value) {
      print("${value.username} ${value.isOnline}");
    });
  }

  Future<void> getSessionAlive() async {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      myOnlineController.sink.add(EnterRequest());
    });
  }

  Future<void> updateBySubscribe() async {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      for (var e in _subscribeUsers) {
        subscribeController.sink.add(SubscribeRequest(id: e));
      }
    });
  }

  bool isOnline(String id) => _onlineUsers[id] ?? false;

  void addSubscribeUser(String id) {
    _subscribeUsers.add(id);
    subscribeController.sink.add(SubscribeRequest(id: id));
  }

  void removeSubscribeUser(String id) {
    _subscribeUsers.remove(id);
    _onlineUsers.remove(id);
  }

  void initSubscribeStream() {
    final request = subscribeController.stream;
    var stream = _client.subscribeUserSession(request);
    stream.listen((value) {
      print("${value.id} ${value.isOnline}");
      _onlineUsers[value.id] = value.isOnline;
    });
  }
}
