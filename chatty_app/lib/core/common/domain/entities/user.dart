import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String avatarUrl;
  final String description;
  final List<String> friends;
  final DocumentSnapshot? documentSnapshot;
  bool isOnline;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.avatarUrl,
    required this.description,
    required this.friends,
    this.documentSnapshot,
    this.isOnline = false,
  });
}
