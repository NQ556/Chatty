import 'package:chatty_app/core/error/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class StatusDatasource {
  Future<void> updateOnlineStatus({
    required String userId,
    required bool isOnline,
  });
}

class StatusDatasourceImpl implements StatusDatasource {
  final FirebaseFirestore _firebaseFirestore;
  StatusDatasourceImpl(this._firebaseFirestore);

  @override
  Future<void> updateOnlineStatus({
    required String userId,
    required bool isOnline,
  }) async {
    try {
      final userDoc = _firebaseFirestore.collection('users').doc(userId);

      final data = {
        'isOnline': isOnline,
      };

      await userDoc.update(data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
