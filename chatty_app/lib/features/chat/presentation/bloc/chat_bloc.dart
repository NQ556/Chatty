import 'package:bloc/bloc.dart';
import 'package:chatty_app/features/chat/domain/entities/chat.dart';
import 'package:chatty_app/features/chat/domain/entities/conversation.dart';
import 'package:chatty_app/features/chat/domain/usecases/chat_get_all_conversations.dart';
import 'package:chatty_app/features/chat/domain/usecases/chat_get_all_messages.dart';
import 'package:chatty_app/features/chat/domain/usecases/chat_send_message.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatSendMessage _chatSendMessage;
  final ChatGetAllMessages _chatGetAllMessages;
  final ChatGetAllConversations _chatGetAllConversations;

  ChatBloc({
    required ChatSendMessage chatSendMessage,
    required ChatGetAllMessages chatGetAllMessages,
    required ChatGetAllConversations chatGetAllConversations,
  })  : _chatSendMessage = chatSendMessage,
        _chatGetAllMessages = chatGetAllMessages,
        _chatGetAllConversations = chatGetAllConversations,
        super(ChatInitial()) {
    on<SendMessageEvent>(_sendMessage);
    on<GetAllMessagesEvent>(_getMessages);
    on<GetConversationsEvent>(_getConversations);
  }

  void _sendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    final response = await _chatSendMessage.call(
      ChatSendMessageParams(
        senderId: event.senderId,
        receiverId: event.receiverId,
        message: event.message,
      ),
    );

    response.fold(
      (failure) => emit(ChatFailureState(failure.message)),
      (chat) => emit(
        SendMessageSuccessState(chat),
      ),
    );
  }

  Future<void> _getMessages(
    GetAllMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    await emit.forEach(
      _chatGetAllMessages.call(
        ChatGetAllMessagesParams(
          userId: event.userId,
          friendId: event.friendId,
        ),
      ),
      onData: (response) {
        return response.fold(
          (failure) => ChatFailureState(failure.message),
          (chats) => GetAllMessagesSuccessState(chats),
        );
      },
      onError: (error, stackTrace) {
        return ChatFailureState(error.toString());
      },
    );
  }

  Future<void> _getConversations(
    GetConversationsEvent event,
    Emitter<ChatState> emit,
  ) async {
    await emit.forEach(
      _chatGetAllConversations
          .call(ChatGetAllConversationsParams(userId: event.userId)),
      onData: (response) {
        return response.fold(
          (failure) => ChatFailureState(failure.message),
          (conversations) => GetConversationsSuccessState(conversations),
        );
      },
      onError: (error, stackTrace) => ChatFailureState(error.toString()),
    );
  }
}
