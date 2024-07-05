import 'package:chatty_app/core/common/domain/entities/user.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/core/usecase/usecase.dart';
import 'package:chatty_app/features/friends/domain/repositories/discovery_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/src/either.dart';

class DiscoveryNewFriends
    implements Usecase<List<User>, DiscoveryNewFriendsParams> {
  final DiscoveryRepository discoveryRepository;
  DiscoveryNewFriends(this.discoveryRepository);

  @override
  Future<Either<Failure, List<User>>> call(
      DiscoveryNewFriendsParams params) async {
    return await discoveryRepository.discoveryNewFriends(
      currentUserId: params.currentUserId,
      limit: params.limit,
      lastDocument: params.lastDocument,
    );
  }
}

class DiscoveryNewFriendsParams {
  final String currentUserId;
  final int limit;
  final DocumentSnapshot? lastDocument;

  DiscoveryNewFriendsParams({
    required this.currentUserId,
    required this.limit,
    required this.lastDocument,
  });
}
