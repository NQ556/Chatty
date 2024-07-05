part of 'discovery_bloc.dart';

@immutable
sealed class DiscoveryState {}

final class DiscoveryInitial extends DiscoveryState {}

final class DiscoveryLoadingState extends DiscoveryState {}

final class GetUsersSuccessState extends DiscoveryState {
  final List<User> users;

  GetUsersSuccessState(
    this.users,
  );
}

final class GetFriendsSuccessState extends DiscoveryState {
  final List<User> users;

  GetFriendsSuccessState(
    this.users,
  );
}

final class DiscoveryEmptyState extends DiscoveryState {}

final class DiscoveryFailureState extends DiscoveryState {
  final String message;
  DiscoveryFailureState(this.message);
}

final class AddFriendSuccessState extends DiscoveryState {
  final User friendUser;
  AddFriendSuccessState(this.friendUser);
}

final class RemoveFriendSuccessState extends DiscoveryState {
  final User friendUser;
  RemoveFriendSuccessState(this.friendUser);
}

final class NoState extends DiscoveryState {}
