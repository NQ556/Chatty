import 'package:chatty_app/core/common/domain/entities/user.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/core/usecase/usecase.dart';
import 'package:chatty_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserGetCurrent implements Usecase<User, NoParams> {
  final AuthRepository authRepository;
  UserGetCurrent(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.getCurrentUserData();
  }
}
