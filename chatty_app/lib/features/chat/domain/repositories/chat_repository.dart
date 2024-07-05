import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/features/chat/domain/entities/chat.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ChatRepository {
  Future<Either<Failure, Chat>> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
  });

  Stream<Either<Failure, List<Chat>>> getAllMessages({
    required String userId,
    required String friendId,
  });
}
