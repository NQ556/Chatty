import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/core/usecase/usecase.dart';
import 'package:chatty_app/features/friends/domain/repositories/discovery_repository.dart';
import 'package:fpdart/src/either.dart';

class FriendAddFriend implements Usecase<void, FriendAddFriendParams> {
  final DiscoveryRepository discoveryRepository;
  FriendAddFriend(this.discoveryRepository);

  @override
  Future<Either<Failure, void>> call(FriendAddFriendParams params) async {
    return await discoveryRepository.addFriend(
      currentUserId: params.currentUserId,
      friendId: params.friendId,
    );
  }
}

class FriendAddFriendParams {
  final String currentUserId;
  final String friendId;

  FriendAddFriendParams({
    required this.currentUserId,
    required this.friendId,
  });
}
