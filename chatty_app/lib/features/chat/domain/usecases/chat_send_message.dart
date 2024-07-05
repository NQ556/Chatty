import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/core/usecase/usecase.dart';
import 'package:chatty_app/features/chat/domain/entities/chat.dart';
import 'package:chatty_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/src/either.dart';

class ChatSendMessage implements Usecase<Chat, ChatSendMessageParams> {
  final ChatRepository chatRepository;
  ChatSendMessage(this.chatRepository);

  @override
  Future<Either<Failure, Chat>> call(ChatSendMessageParams params) async {
    return await chatRepository.sendMessage(
      senderId: params.senderId,
      receiverId: params.receiverId,
      message: params.message,
    );
  }
}

class ChatSendMessageParams {
  final String senderId;
  final String receiverId;
  final String message;

  ChatSendMessageParams({
    required this.senderId,
    required this.receiverId,
    required this.message,
  });
}
