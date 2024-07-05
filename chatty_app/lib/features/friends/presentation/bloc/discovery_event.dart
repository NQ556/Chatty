part of 'discovery_bloc.dart';

@immutable
sealed class DiscoveryEvent {}

final class DiscoveryFriendsEvent extends DiscoveryEvent {
  final String currentUserId;
  final int limit;
  final DocumentSnapshot? lastDocument;

  DiscoveryFriendsEvent({
    required this.currentUserId,
    required this.limit,
    this.lastDocument,
  });
}

final class AddFriendEvent extends DiscoveryEvent {
  final String currentUserId;
  final String friendId;
  final User friendUser;

  AddFriendEvent({
    required this.currentUserId,
    required this.friendId,
    required this.friendUser,
  });
}

final class GetFriendsEvent extends DiscoveryEvent {
  final String currentUserId;
  final int limit;
  final DocumentSnapshot? lastDocument;

  GetFriendsEvent({
    required this.currentUserId,
    required this.limit,
    this.lastDocument,
  });
}

final class RemoveFriendEvent extends DiscoveryEvent {
  final String currentUserId;
  final String friendId;
  final User friendUser;

  RemoveFriendEvent({
    required this.currentUserId,
    required this.friendId,
    required this.friendUser,
  });
}

final class ReloadEvent extends DiscoveryEvent {}
