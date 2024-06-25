import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/core/usecase/usecase.dart';
import 'package:chatty_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserResetPassword implements Usecase<void, UserResetPasswordParams> {
  final AuthRepository authRepository;
  UserResetPassword(this.authRepository);

  @override
  Future<Either<Failure, void>> call(UserResetPasswordParams params) {
    return authRepository.resetPassword(
      email: params.email,
    );
  }
}

class UserResetPasswordParams {
  final String email;

  UserResetPasswordParams({
    required this.email,
  });
}
