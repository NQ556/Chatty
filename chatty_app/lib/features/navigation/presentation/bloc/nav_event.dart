part of 'nav_bloc.dart';

@immutable
sealed class NavEvent {}

final class NavConversationEvent extends NavEvent {}

final class NavFriendsEvent extends NavEvent {}

final class NavDiscoveryEvent extends NavEvent {}

final class NavProfileEvent extends NavEvent {}
