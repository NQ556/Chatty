part of 'nav_bloc.dart';

@immutable
sealed class NavEvent {}

final class NavConversation extends NavEvent {}

final class NavFriends extends NavEvent {}

final class NavDiscovery extends NavEvent {}

final class NavProfile extends NavEvent {}
