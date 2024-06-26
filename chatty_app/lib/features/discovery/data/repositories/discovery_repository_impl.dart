import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/core/error/exception.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/features/discovery/data/datasources/discovery_datasource.dart';
import 'package:chatty_app/features/discovery/domain/repositories/discovery_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/src/either.dart';

class DiscoveryRepositoryImpl implements DiscoveryRepository {
  final DiscoveryDatasource discoveryDatasource;
  DiscoveryRepositoryImpl(this.discoveryDatasource);

  @override
  Future<Either<Failure, List<User>>> discoveryNewFriends(
      {required String currentUserId,
      required int limit,
      DocumentSnapshot<Object?>? lastDocument}) async {
    try {
      final users = await discoveryDatasource.discoveryNewFriends(
        currentUserId: currentUserId,
        limit: limit,
        lastDocument: lastDocument,
      );

      return right(users);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
