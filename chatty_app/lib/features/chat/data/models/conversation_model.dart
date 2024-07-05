import 'package:chatty_app/features/chat/domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  ConversationModel({
    required super.friendUser,
    required super.lastMessage,
    required super.timeStamp,
    required super.isCurrentUser,
  });
}
