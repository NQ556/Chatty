import 'package:chatty_app/core/error/exception.dart';
import 'package:chatty_app/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

abstract interface class AuthDataSource {
  Future<UserModel> signUpWithEmail({
    required String username,
    required String email,
    required String password,
  });
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseDatabase _firebaseDatabase;

  AuthDataSourceImpl(
    this._firebaseAuth,
    this._firebaseDatabase,
  );

  @override
  Future<UserModel> signUpWithEmail(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw const ServerException("Null User!");
      } else {
        UserModel userModel = UserModel.fromUser(userCredential.user!).copyWith(
          username: username,
        );
        _firebaseDatabase
            .ref("User")
            .child(userCredential.user!.uid)
            .set(userModel.toUser());
      }

      return UserModel.fromUser(userCredential.user!).copyWith(
        username: username,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
