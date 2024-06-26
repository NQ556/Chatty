part of 'nav_bloc.dart';

@immutable
sealed class NavState {}

final class NavInitial extends NavState {}

final class ConversationState extends NavState {}

final class FriendsState extends NavState {}

final class DiscoveryState extends NavState {}

final class ProfileState extends NavState {}
