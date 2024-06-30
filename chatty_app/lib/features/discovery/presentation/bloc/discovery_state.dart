part of 'discovery_bloc.dart';

@immutable
sealed class DiscoveryState {}

final class DiscoveryInitial extends DiscoveryState {}

final class DiscoveryLoadingState extends DiscoveryState {}

final class DiscoverySuccessState extends DiscoveryState {
  final List<User> users;

  DiscoverySuccessState(
    this.users,
  );
}

final class DiscoveryEmptyState extends DiscoveryState {}

final class DiscoveryFailureState extends DiscoveryState {
  final String message;
  DiscoveryFailureState(this.message);
}
