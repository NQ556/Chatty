part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class UpdateSuccess extends ProfileState {
  final User user;
  UpdateSuccess(this.user);
}

final class UploadSuccess extends ProfileState {
  final String imageUrl;
  UploadSuccess(this.imageUrl);
}

final class EditFailure extends ProfileState {
  final String message;
  EditFailure(this.message);
}
