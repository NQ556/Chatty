import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/features/chat/domain/entities/conversation.dart';
import 'package:chatty_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChatGetAllConversations {
  final ChatRepository chatRepository;
  ChatGetAllConversations(this.chatRepository);

  Stream<Either<Failure, List<Conversation>>> call(
      ChatGetAllConversationsParams params) {
    return chatRepository.getConversations(
      userId: params.userId,
    );
  }
}

class ChatGetAllConversationsParams {
  final String userId;

  ChatGetAllConversationsParams({required this.userId});
}
