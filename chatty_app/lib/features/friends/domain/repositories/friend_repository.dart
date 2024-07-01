import 'package:chatty_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class FriendRepository {
  Future<Either<Failure, void>> addFriend({
    required String currentUserId,
    required String friendId,
  });
}
