import 'package:chatty_app/core/common/domain/entities/user.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmail({
    required String username,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> resetPassword({
    required String email,
  });

  Future<Either<Failure, User>> getCurrentUserData();

  Future<Either<Failure, void>> signOutAccount();
}
