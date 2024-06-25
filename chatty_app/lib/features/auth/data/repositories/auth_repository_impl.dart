import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/core/error/exception.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:chatty_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  const AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Failure, User>> signUpWithEmail({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final user = await authDataSource.signUpWithEmail(
        username: username,
        email: email,
        password: password,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final user = await authDataSource.signInWithEmail(
        email: email,
        password: password,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await authDataSource.resetPassword(email: email);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
