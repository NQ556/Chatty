part of 'nav_bloc.dart';

@immutable
sealed class NavState {}

final class NavInitial extends NavState {}

final class NavConversationState extends NavState {}

final class NavFriendsState extends NavState {}

final class NavDiscoveryState extends NavState {}

final class NavProfileState extends NavState {}
