import 'dart:io';
import 'package:chatty_app/core/error/exception.dart';
import 'package:chatty_app/core/common/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract interface class ProfileDataSource {
  Future<UserModel> updateUserInformation({
    required String userId,
    required String username,
    required String description,
    required String avatarUrl,
  });

  Future<String> uploadImageToStorage({
    required File image,
    required String oldUrl,
  });
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  ProfileDataSourceImpl(
    this._firebaseFirestore,
    this._firebaseStorage,
  );

  String _getFileNameFromPath(String path) {
    return path.split('/').last;
  }

  Future<void> _deleteImageFromStorage(String imageUrl) async {
    try {
      await _firebaseStorage.refFromURL(imageUrl).delete();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> updateUserInformation({
    required String userId,
    required String username,
    required String description,
    required String avatarUrl,
  }) async {
    try {
      final userDoc = _firebaseFirestore.collection('users').doc(userId);

      final data = {
        'username': username,
        'description': description,
        'avatarUrl': avatarUrl,
      };

      await userDoc.update(data);

      final userInfo = await userDoc.get();

      // Fail fetch data
      if (userInfo.data() == null) {
        throw const ServerException("Null User!");
      }

      return UserModel.fromMap(userInfo.data()!).copyWith(id: userId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadImageToStorage({
    required File image,
    required String oldUrl,
  }) async {
    try {
      if (oldUrl.isNotEmpty) {
        _deleteImageFromStorage(oldUrl);
      }

      Reference storageReference = _firebaseStorage
          .ref()
          .child('Avatar/${_getFileNameFromPath(image.path)}');

      final snapShot = await storageReference.putFile(image);
      final result = await snapShot.ref.getDownloadURL();

      return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
