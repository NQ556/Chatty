import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:chatty_app/core/usecase/usecase.dart';
import 'package:chatty_app/features/discovery/domain/repositories/discovery_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/src/either.dart';

class DiscoveryShowNewFriends
    implements Usecase<List<User>, DiscoveryShowNewFriendsParams> {
  final DiscoveryRepository discoveryRepository;
  DiscoveryShowNewFriends(this.discoveryRepository);

  @override
  Future<Either<Failure, List<User>>> call(
      DiscoveryShowNewFriendsParams params) async {
    return await discoveryRepository.discoveryNewFriends(
      currentUserId: params.currentUserId,
      limit: params.limit,
      lastDocument: params.lastDocument,
    );
  }
}

class DiscoveryShowNewFriendsParams {
  final String currentUserId;
  final int limit;
  final DocumentSnapshot? lastDocument;

  DiscoveryShowNewFriendsParams({
    required this.currentUserId,
    required this.limit,
    required this.lastDocument,
  });
}
