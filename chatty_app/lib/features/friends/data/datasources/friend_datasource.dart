import 'package:chatty_app/core/error/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class FriendDatasource {
  Future<void> addFriend({
    required String currentUserId,
    required String friendId,
  });
}

class FriendDatasourceImpl implements FriendDatasource {
  final FirebaseFirestore _firebaseFirestore;
  FriendDatasourceImpl(this._firebaseFirestore);

  @override
  Future<void> addFriend({
    required String currentUserId,
    required String friendId,
  }) async {
    try {
      DocumentReference documentReference =
          _firebaseFirestore.collection('users').doc(currentUserId);

      await documentReference.update({
        'friends': FieldValue.arrayUnion([friendId]),
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
