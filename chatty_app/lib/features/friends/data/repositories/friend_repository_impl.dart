import 'package:chatty_app/core/error/exception.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/features/friends/data/datasources/friend_datasource.dart';
import 'package:chatty_app/features/friends/domain/repositories/friend_repository.dart';
import 'package:fpdart/fpdart.dart';

class FriendRepositoryImpl implements FriendRepository {
  final FriendDatasource friendDatasource;
  FriendRepositoryImpl(this.friendDatasource);

  @override
  Future<Either<Failure, void>> addFriend({
    required String currentUserId,
    required String friendId,
  }) async {
    try {
      await friendDatasource.addFriend(
        currentUserId: currentUserId,
        friendId: friendId,
      );

      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
