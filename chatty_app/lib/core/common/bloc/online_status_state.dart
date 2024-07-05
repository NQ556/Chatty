part of 'online_status_bloc.dart';

@immutable
sealed class OnlineStatusState {}

final class OnlineStatusInitial extends OnlineStatusState {}

class StatusUpdatedState extends OnlineStatusState {
  final bool isOnline;
  StatusUpdatedState(this.isOnline);
}

class StatusFailureState extends OnlineStatusState {
  final String message;
  StatusFailureState(this.message);
}
