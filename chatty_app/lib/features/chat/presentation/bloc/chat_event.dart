part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class SendMessageEvent extends ChatEvent {
  final String senderId;
  final String receiverId;
  final String message;

  SendMessageEvent({
    required this.senderId,
    required this.receiverId,
    required this.message,
  });
}

final class GetAllMessagesEvent extends ChatEvent {
  final String userId;
  final String friendId;

  GetAllMessagesEvent({
    required this.userId,
    required this.friendId,
  });
}

class GetConversationsEvent extends ChatEvent {
  final String userId;
  GetConversationsEvent({required this.userId});
}
