import 'package:fixnum/fixnum.dart';
import '../../generated/chat.pb.dart';
import '../../generated/user.pb.dart';

abstract class ChatRepository {
  Future<List<ChatPreview>> getChatsPreview (String token);
  Future<Chat> joinChat (Int64 chatId, String token);
}