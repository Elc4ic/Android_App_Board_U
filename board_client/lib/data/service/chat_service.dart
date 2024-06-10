import 'package:board_client/generated/ad.pb.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:grpc/grpc.dart';
import 'package:fixnum/fixnum.dart' as fnum;

import '../../generated/chat.pbgrpc.dart';
import '../../values/values.dart';
import '../repository/chat_repository.dart';

class ChatService implements ChatRepository {
  late ChatAPIClient _client;

  ChatService() {
    final channel = ClientChannel(
      Const.HOST,
      port: Const.PORT,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _client = ChatAPIClient(channel);
  }

  @override
  Future<List<ChatPreview>> getChatsPreview(String? token) async {
    final response = await _client.getChatsPreview(JwtProto(token: token));
    return response.chats;
  }

  @override
  Future<GetAllMessagesResponse> getMessages(int id, String? token) async {
    final response = await _client.getAllMessage(
        GetAllMessagesRequest(chatId: fnum.Int64(id), token: token));
    return response;
  }

  @override
  Stream<Message> sendMessage(Stream<SendMessageRequest> stream) {
    return _client.sendMessage(stream);
  }

  @override
  Future<fnum.Int64> startChat(Ad ad, String? token) async {
    final response = await _client.startChat(StartRequest(ad: ad, token: token));
    return response.chatId;
  }
}
