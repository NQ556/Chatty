import 'package:chatty_app/core/common/models/user_model.dart';
import 'package:chatty_app/core/error/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class DiscoveryDatasource {
  Future<List<UserModel>> discoveryNewFriends({
    required String currentUserId,
    required int limit,
    DocumentSnapshot? lastDocument,
  });

  Future<void> addFriend({
    required String currentUserId,
    required String friendId,
  });
}

class DiscoveryDataSourceImpl implements DiscoveryDatasource {
  final FirebaseFirestore _firebaseFirestore;

  DiscoveryDataSourceImpl(this._firebaseFirestore);

  Future<List<String>> _getCurrentUserFriends(String userUID) async {
    final userInfo =
        await _firebaseFirestore.collection('users').doc(userUID).get();

    if (userInfo.data() == null) {
      throw const ServerException("Null User!");
    }

    List<dynamic> friendsDynamic = userInfo.data()!['friends'];
    List<String> friendsList =
        friendsDynamic.map((friend) => friend.toString()).toList();

    return friendsList;
  }

  @override
  Future<List<UserModel>> discoveryNewFriends(
      {required String currentUserId,
      required int limit,
      DocumentSnapshot<Object?>? lastDocument}) async {
    try {
      List<UserModel> newFriends = [];
      List<String> currentFriends = await _getCurrentUserFriends(currentUserId);
      DocumentSnapshot? lastFetchedDocument = lastDocument;

      while (newFriends.length < limit) {
        // Fetch a batch of users
        Query query = _firebaseFirestore
            .collection('users')
            .where(FieldPath.documentId, isNotEqualTo: currentUserId)
            .limit(limit);

        if (lastFetchedDocument != null) {
          query = query.startAfterDocument(lastFetchedDocument);
        }

        final response = await query.get();

        if (response.docs.isEmpty) {
          break;
        }

        final batchUsers = response.docs.map((doc) {
          return UserModel.fromMap(doc.data() as Map<String, dynamic>).copyWith(
            id: doc.id,
            documentSnapshot: doc,
          );
        }).toList();

        // Filter out friends
        final filteredUsers = batchUsers.where((user) {
          return !currentFriends.contains(user.id);
        }).toList();

        newFriends.addAll(filteredUsers);

        if (newFriends.length >= limit) {
          newFriends = newFriends.take(limit).toList();
          break;
        }

        // Update the last fetched document for pagination
        lastFetchedDocument = response.docs.last;
      }

      return newFriends;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> addFriend(
      {required String currentUserId, required String friendId}) async {
    try {
      DocumentReference documentReference =
          _firebaseFirestore.collection('users').doc(currentUserId);
      DocumentReference documentReference_2 =
          _firebaseFirestore.collection('users').doc(friendId);

      await documentReference.update({
        'friends': FieldValue.arrayUnion([friendId]),
      });

      await documentReference_2.update({
        'friends': FieldValue.arrayUnion([currentUserId])
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
