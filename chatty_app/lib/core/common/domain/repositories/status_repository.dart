import 'package:chatty_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class StatusRepository {
  Future<Either<Failure, void>> updateOnlineStatus({
    required String userId,
    required bool isOnline,
  });
}
