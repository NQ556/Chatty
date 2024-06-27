import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/core/usecase/usecase.dart';
import 'package:chatty_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignOut implements Usecase<void, NoParams> {
  final AuthRepository authRepository;
  UserSignOut(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return authRepository.signOutAccount();
  }
}
