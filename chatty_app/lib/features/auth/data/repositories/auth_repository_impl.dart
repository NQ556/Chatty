import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/core/error/exception.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:chatty_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/src/either.dart';

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
}
