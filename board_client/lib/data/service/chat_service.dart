import 'package:board_client/generated/ad.pb.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:grpc/grpc.dart';
import 'package:fixnum/fixnum.dart';

import '../../generated/chat.pbgrpc.dart';
import '../../values/values.dart';

class ChatService {
  late ChatAPIClient _client;

  void initClient(String? token) {
    final channel = ClientChannel(
      Const.HOST,
      port: Const.PORT,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _client = ChatAPIClient(
      channel,
      options: CallOptions(metadata: {'token': token ?? ""}),
    );
  }

  Future<List<ChatPreview>> getChatsPreview() async {
    final response = await _client.getChatsPreview(Empty());
    return response.chats;
  }

  Future<GetAllMessagesResponse> getMessages(int id) async {
    final response = await _client
        .getAllMessage(GetAllMessagesRequest(chatId: Int64(id)));
    return response;
  }

  Stream<Message> sendMessage(Stream<SendMessageRequest> stream) {
    return _client.sendMessage(stream);
  }

  Future<Int64> startChat(Ad ad) async {
    final response =
        await _client.startChat(StartRequest(ad: ad));
    return response.chatId;
  }

  Future<void> deleteChat(Int64 chatId) async {
    await _client.deleteChat(DeleteChatRequest(chatId: chatId));
  }

  Future<void> deleteMessage(Int64 messageId) async {
    await _client
        .deleteMessage(DeleteChatRequest(chatId: messageId));
  }
}
