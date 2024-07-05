import 'package:chatty_app/core/common/domain/entities/user.dart';
import 'package:chatty_app/core/error/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class DiscoveryRepository {
  Future<Either<Failure, List<User>>> discoveryNewFriends({
    required String currentUserId,
    required int limit,
    DocumentSnapshot? lastDocument,
  });

  Future<Either<Failure, void>> addFriend({
    required String currentUserId,
    required String friendId,
  });

  Future<Either<Failure, List<User>>> getFriends({
    required String currentUserId,
    required int limit,
    DocumentSnapshot? lastDocument,
  });

  Future<Either<Failure, void>> removeFriend({
    required String currentUserId,
    required String friendId,
  });
}
