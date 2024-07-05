// ignore_for_file: public_member_api_docs, sort_constructors_first
class Chat {
  final String senderId;
  final String receiverId;
  final String conversationId;
  final String message;
  final DateTime timeSent;

  Chat({
    required this.senderId,
    required this.receiverId,
    required this.conversationId,
    required this.message,
    required this.timeSent,
  });
}
