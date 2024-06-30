import 'package:chatty_app/core/error/exception.dart';
import 'package:chatty_app/core/common/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthDataSource {
  Future<UserModel> signUpWithEmail({
    required String username,
    required String email,
    required String password,
  });

  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });

  Future<void> resetPassword({
    required String email,
  });

  Future<UserModel?> getCurrentUserData();

  Future<void> signOutAccount();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthDataSourceImpl(
    this._firebaseAuth,
    this._firebaseFirestore,
  );

  Future<UserModel> _getUserData(String userUID) async {
    // Get user's information from database
    final userInfo =
        await _firebaseFirestore.collection('users').doc(userUID).get();

    // Fail fetch data
    if (userInfo.data() == null) {
      throw const ServerException("Null User!");
    }

    return UserModel.fromMap(userInfo.data()!).copyWith(id: userUID);
  }

  @override
  Future<UserModel> signUpWithEmail({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      // Register new account
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Register fails
      if (userCredential.user == null) {
        throw const ServerException("Null User!");
      }

      // Get user and update username
      UserModel userModel = UserModel.fromUser(userCredential.user!).copyWith(
        username: username,
      );

      // Push to database
      _firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toUser());

      return userModel;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fail to sign in
      if (response.user == null) {
        throw const ServerException("Null User!");
      }

      return _getUserData(response.user!.uid);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (_firebaseAuth.currentUser != null) {
        return _getUserData(_firebaseAuth.currentUser!.uid);
      }

      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOutAccount() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
