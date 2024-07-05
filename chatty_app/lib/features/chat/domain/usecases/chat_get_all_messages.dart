import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/features/chat/domain/entities/chat.dart';
import 'package:chatty_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/src/either.dart';

class ChatGetAllMessages {
  final ChatRepository chatRepository;

  ChatGetAllMessages(this.chatRepository);

  Stream<Either<Failure, List<Chat>>> call(ChatGetAllMessagesParams params) {
    return chatRepository.getAllMessages(
      userId: params.userId,
      friendId: params.friendId,
    );
  }
}

class ChatGetAllMessagesParams {
  final String userId;
  final String friendId;

  ChatGetAllMessagesParams({
    required this.userId,
    required this.friendId,
  });
}
