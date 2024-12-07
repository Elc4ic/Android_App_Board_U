import 'dart:async';

import 'package:grpc/grpc.dart';

import '../../generated/session.pbgrpc.dart';
import '../../values/values.dart';

class SessionService {
  late SessionAPIClient _client;
  final StreamController<EnterRequest> streamController =
      StreamController<EnterRequest>();
  UserStatus status = UserStatus();

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
  }

  void registerSession() {
    final request = streamController.stream;
    var stream = _client.registerSession(request);
    stream.listen((value) {
      status = value;
    });
  }

  Future<void> getSessionAlive() async {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      streamController.sink.add(EnterRequest());
    });
  }

  Stream<UserStatus> subscribeById(Stream<SubscribeRequest> request) {
    return _client.subscribeUserSession(request);
  }
}
