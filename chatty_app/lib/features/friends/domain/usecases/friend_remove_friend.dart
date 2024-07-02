import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/core/usecase/usecase.dart';
import 'package:chatty_app/features/friends/domain/repositories/discovery_repository.dart';
import 'package:fpdart/src/either.dart';

class FriendRemoveFriend implements Usecase<void, FriendRemoveFriendParams> {
  final DiscoveryRepository discoveryRepository;
  FriendRemoveFriend(this.discoveryRepository);

  @override
  Future<Either<Failure, void>> call(FriendRemoveFriendParams params) async {
    return await discoveryRepository.removeFriend(
      currentUserId: params.currentUserId,
      friendId: params.friendId,
    );
  }
}

class FriendRemoveFriendParams {
  final String currentUserId;
  final String friendId;

  FriendRemoveFriendParams({
    required this.currentUserId,
    required this.friendId,
  });
}
