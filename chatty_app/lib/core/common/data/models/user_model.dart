import 'dart:convert';

import 'package:chatty_app/core/common/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;

class UserModel extends User {
  UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.avatarUrl,
    required super.description,
    required super.friends,
    super.documentSnapshot,
    super.isOnline,
  });

  factory UserModel.fromUser(FirebaseAuth.User user) {
    return UserModel(
      id: user.uid,
      username: '',
      email: user.email.toString(),
      avatarUrl: '',
      description: '',
      friends: [],
      isOnline: false,
    );
  }

  Map<String, dynamic> toUser() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'avatarUrl': avatarUrl,
      'description': description,
      'friends': friends,
      'isOnline': isOnline,
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
      'isOnline': isOnline,
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
      isOnline: map['isOnline'] as bool,
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
    DocumentSnapshot? documentSnapshot,
    bool? isOnline,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      description: description ?? this.description,
      friends: friends ?? this.friends,
      documentSnapshot: documentSnapshot ?? this.documentSnapshot,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
