import 'package:chatty_app/core/error/exception.dart';
import 'package:chatty_app/features/chat/data/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class ChatDatasource {
  Future<ChatModel> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
  });

  Stream<List<ChatModel>> getAllMessages({
    required String userId,
    required String friendId,
  });
}

class ChatDatasourceImpl implements ChatDatasource {
  final FirebaseFirestore _firebaseFirestore;
  ChatDatasourceImpl(this._firebaseFirestore);

  @override
  Future<ChatModel> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    try {
      var timeSent = DateTime.now();

      final data = {
        'senderId': senderId,
        'receiverId': receiverId,
        'message': message,
        'timeSent': Timestamp.fromDate(timeSent),
      };

      // Push to database
      final response = await _firebaseFirestore.collection('chats').add(data);

      return ChatModel.fromMap(data).copyWith(
        conversationId: response.id,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<List<ChatModel>> getAllMessages({
    required String userId,
    required String friendId,
  }) {
    try {
      final userMessagesStream = _firebaseFirestore
          .collection('chats')
          .where('senderId', isEqualTo: userId)
          .where('receiverId', isEqualTo: friendId)
          .orderBy('timeSent')
          .snapshots();

      final friendMessagesStream = _firebaseFirestore
          .collection('chats')
          .where('senderId', isEqualTo: friendId)
          .where('receiverId', isEqualTo: userId)
          .orderBy('timeSent')
          .snapshots();

      return CombineLatestStream.list(
          [userMessagesStream, friendMessagesStream]).map(
        (snapshots) {
          final userMessages = snapshots[0].docs;
          final friendMessages = snapshots[1].docs;
          final allMessages = [...userMessages, ...friendMessages];

          allMessages.sort((a, b) => (a.data()['timeSent'] as Timestamp)
              .compareTo(b.data()['timeSent'] as Timestamp));

          return allMessages
              .map(
                (doc) => ChatModel.fromMap(doc.data()).copyWith(
                  conversationId: doc.id,
                ),
              )
              .toList();
        },
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
