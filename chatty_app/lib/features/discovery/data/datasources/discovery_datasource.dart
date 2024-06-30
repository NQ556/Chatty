import 'package:chatty_app/core/common/models/user_model.dart';
import 'package:chatty_app/core/error/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class DiscoveryDatasource {
  Future<List<UserModel>> discoveryNewFriends({
    required String currentUserId,
    required int limit,
    DocumentSnapshot? lastDocument,
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
      // Create a query to fetch users
      Query query = _firebaseFirestore
          .collection('users')
          .where(FieldPath.documentId, isNotEqualTo: currentUserId)
          .limit(limit);

      // If lastDocument is provided, start after it for pagination
      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      // Get all users
      final response = await query.get();

      // Check if there are any documents returned
      if (response.docs.isEmpty) {
        return [];
      }

      final allUsers = response.docs
          .map(
            (doc) =>
                UserModel.fromMap(doc.data() as Map<String, dynamic>).copyWith(
              id: doc.id,
              documentSnapshot: doc,
            ),
          )
          .toList();

      // Filter out friends
      List<String> currentFriends = await _getCurrentUserFriends(currentUserId);

      final newFriends = allUsers.where(
        (user) {
          return !currentFriends.contains(user.id);
        },
      ).toList();

      return newFriends;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
