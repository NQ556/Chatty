import 'dart:convert';

import 'package:chatty_app/features/friends/domain/entities/friend_request.dart';

class FriendRequestModel extends FriendRequest {
  FriendRequestModel({
    required super.sendId,
    required super.receivedId,
    required super.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sendId': sendId,
      'receivedId': receivedId,
      'status': status,
    };
  }

  factory FriendRequestModel.fromMap(Map<String, dynamic> map) {
    return FriendRequestModel(
      sendId: map['sendId'] as String,
      receivedId: map['receivedId'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FriendRequestModel.fromJson(String source) =>
      FriendRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  FriendRequestModel copyWith({
    String? sendId,
    String? receivedId,
    String? status,
  }) {
    return FriendRequestModel(
      sendId: sendId ?? this.sendId,
      receivedId: receivedId ?? this.receivedId,
      status: status ?? this.status,
    );
  }
}
