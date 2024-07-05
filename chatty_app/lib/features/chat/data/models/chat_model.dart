import 'dart:convert';

import 'package:chatty_app/features/chat/domain/entities/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel extends Chat {
  ChatModel({
    required super.senderId,
    required super.receiverId,
    required super.conversationId,
    required super.message,
    required super.timeSent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'conversationId': conversationId,
      'message': message,
      'timeSent': Timestamp.fromDate(timeSent),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      conversationId: '',
      message: map['message'] as String,
      timeSent: (map['timeSent'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ChatModel copyWith({
    String? senderId,
    String? receiverId,
    String? conversationId,
    String? message,
    DateTime? timeSent,
  }) {
    return ChatModel(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      conversationId: conversationId ?? this.conversationId,
      message: message ?? this.message,
      timeSent: timeSent ?? this.timeSent,
    );
  }
}
