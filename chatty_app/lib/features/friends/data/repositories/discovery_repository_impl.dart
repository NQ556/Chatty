import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/core/error/exception.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/features/friends/data/datasources/discovery_datasource.dart';
import 'package:chatty_app/features/friends/domain/repositories/discovery_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

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

  @override
  Future<Either<Failure, void>> addFriend({
    required String currentUserId,
    required String friendId,
  }) async {
    try {
      await discoveryDatasource.addFriend(
        currentUserId: currentUserId,
        friendId: friendId,
      );

      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getFriends({
    required String currentUserId,
    required int limit,
    DocumentSnapshot<Object?>? lastDocument,
  }) async {
    try {
      final users = await discoveryDatasource.getFriends(
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
