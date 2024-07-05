import 'package:chatty_app/core/common/data/datasource/status_datasource.dart';
import 'package:chatty_app/core/common/domain/repositories/status_repository.dart';
import 'package:chatty_app/core/error/exception.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

class StatusRepositoryImpl implements StatusRepository {
  final StatusDatasource statusDatasource;
  StatusRepositoryImpl(this.statusDatasource);

  @override
  Future<Either<Failure, void>> updateOnlineStatus({
    required String userId,
    required bool isOnline,
  }) async {
    try {
      await statusDatasource.updateOnlineStatus(
        userId: userId,
        isOnline: isOnline,
      );
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
