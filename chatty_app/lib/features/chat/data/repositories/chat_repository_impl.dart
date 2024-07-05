import 'package:chatty_app/core/error/exception.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/features/chat/data/datasources/chat_datasource.dart';
import 'package:chatty_app/features/chat/domain/entities/chat.dart';
import 'package:chatty_app/features/chat/domain/entities/conversation.dart';
import 'package:chatty_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:fpdart/src/either.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDatasource chatDatasource;
  ChatRepositoryImpl(this.chatDatasource);

  @override
  Future<Either<Failure, Chat>> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    try {
      final chat = await chatDatasource.sendMessage(
        senderId: senderId,
        receiverId: receiverId,
        message: message,
      );

      return right(chat);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Stream<Either<Failure, List<Chat>>> getAllMessages(
      {required String userId, required String friendId}) async* {
    try {
      final stream = chatDatasource.getAllMessages(
        userId: userId,
        friendId: friendId,
      );

      await for (final chats in stream) {
        yield right(chats);
      }
    } on ServerException catch (e) {
      yield left(Failure(e.message));
    }
  }

  @override
  Stream<Either<Failure, List<Conversation>>> getConversations(
      {required String userId}) async* {
    try {
      final stream = chatDatasource.getConversations(userId: userId);

      await for (final conversations in stream) {
        yield right(conversations);
      }
    } on ServerException catch (e) {
      yield left(Failure(e.message));
    }
  }
}
