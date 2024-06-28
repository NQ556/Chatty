part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class ProfileUpdate extends ProfileEvent {
  final String userId;
  final String username;
  final String description;
  final String avatarUrl;

  ProfileUpdate({
    required this.userId,
    required this.username,
    required this.description,
    required this.avatarUrl,
  });
}

final class ProfileUpload extends ProfileEvent {
  final File image;
  final String oldUrl;

  ProfileUpload({
    required this.image,
    required this.oldUrl,
  });
}
