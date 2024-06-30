part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class ProfileUpdateEvent extends ProfileEvent {
  final String userId;
  final String username;
  final String description;
  final String avatarUrl;

  ProfileUpdateEvent({
    required this.userId,
    required this.username,
    required this.description,
    required this.avatarUrl,
  });
}

final class ProfileUploadEvent extends ProfileEvent {
  final File image;
  final String oldUrl;

  ProfileUploadEvent({
    required this.image,
    required this.oldUrl,
  });
}
