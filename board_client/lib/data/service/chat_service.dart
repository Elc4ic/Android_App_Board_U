import 'package:fixnum/fixnum.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:grpc/grpc.dart';

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
  Future<List<ChatPreview>> getChatsPreview(String token) async {
    final response = await _client.getChatsPreview(JwtProto(token: token));
    return response.chats;
  }

  @override
  Future<Chat> joinChat(Int64 chatId, String token) async {
    final response =
        await _client.joinChat(JoinRequest(chatId: chatId, jwt: token));
    return response;
  }

}
