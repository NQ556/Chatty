import 'dart:convert';

import 'package:chatty_app/core/common/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;

class UserModel extends User {
  UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.avatarUrl,
    required super.description,
    required super.friends,
  });

  factory UserModel.fromUser(FirebaseAuth.User user) {
    return UserModel(
      id: user.uid,
      username: '',
      email: user.email.toString(),
      avatarUrl: '',
      description: '',
      friends: [],
    );
  }

  Map<String, dynamic> toUser() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'avatarUrl': avatarUrl,
      'description': description,
      'friends': friends,
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'avatarUrl': avatarUrl,
      'description': description,
      'friends': friends,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: '',
      username: map['username'] as String,
      email: map['email'] as String,
      avatarUrl: map['avatarUrl'] as String,
      description: map['description'] as String,
      friends: List<String>.from(
        (map['friends'] as List<dynamic>).map((item) => item as String),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
    String? avatarUrl,
    String? description,
    List<String>? friends,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      description: description ?? this.description,
      friends: friends ?? this.friends,
    );
  }
}
