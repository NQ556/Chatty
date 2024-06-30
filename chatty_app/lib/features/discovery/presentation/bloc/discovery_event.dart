part of 'discovery_bloc.dart';

@immutable
sealed class DiscoveryEvent {}

final class ShowFriendsEvent extends DiscoveryEvent {
  final String currentUserId;
  final int limit;
  final DocumentSnapshot? lastDocument;

  ShowFriendsEvent({
    required this.currentUserId,
    required this.limit,
    this.lastDocument,
  });
}
