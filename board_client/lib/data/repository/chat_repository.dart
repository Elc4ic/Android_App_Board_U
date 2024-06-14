import '../../generated/ad.pb.dart';
import '../../generated/chat.pb.dart';
import 'package:fixnum/fixnum.dart';

abstract class ChatRepository {
  Future<List<ChatPreview>> getChatsPreview(String? token);

  Stream<Message> sendMessage(Stream<SendMessageRequest> stream);

  Future<GetAllMessagesResponse> getMessages(int id, String? token);

  Future<Int64> startChat(Ad ad,String? token);

  Future<void> deleteChat(Int64 chatId,String? token);
}
