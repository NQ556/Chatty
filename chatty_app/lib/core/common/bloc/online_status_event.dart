part of 'online_status_bloc.dart';

@immutable
sealed class OnlineStatusEvent {}

class UpdateOnlineStatusEvent extends OnlineStatusEvent {
  final String userId;
  final bool isOnline;

  UpdateOnlineStatusEvent({
    required this.userId,
    required this.isOnline,
  });
}
