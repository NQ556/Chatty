import 'package:chatty_app/core/common/domain/repositories/status_repository.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/core/usecase/usecase.dart';
import 'package:fpdart/src/either.dart';

class StatusUpdate implements Usecase<void, StatusUpdateParams> {
  final StatusRepository statusRepository;
  StatusUpdate(this.statusRepository);

  @override
  Future<Either<Failure, void>> call(StatusUpdateParams params) {
    return statusRepository.updateOnlineStatus(
      userId: params.userId,
      isOnline: params.isOnline,
    );
  }
}

class StatusUpdateParams {
  final String userId;
  final bool isOnline;

  StatusUpdateParams({
    required this.userId,
    required this.isOnline,
  });
}
