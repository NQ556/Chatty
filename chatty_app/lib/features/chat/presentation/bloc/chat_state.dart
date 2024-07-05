part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class SendMessageSuccessState extends ChatState {
  final Chat chat;
  SendMessageSuccessState(this.chat);
}

final class ChatFailureState extends ChatState {
  final String message;
  ChatFailureState(this.message);
}

final class GetAllMessagesSuccessState extends ChatState {
  final List<Chat> chats;
  GetAllMessagesSuccessState(this.chats);
}
