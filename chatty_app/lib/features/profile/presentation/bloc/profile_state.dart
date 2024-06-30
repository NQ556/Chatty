part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class UpdateSuccessState extends ProfileState {
  final User user;
  UpdateSuccessState(this.user);
}

final class UploadSuccessState extends ProfileState {
  final String imageUrl;
  UploadSuccessState(this.imageUrl);
}

final class EditFailureState extends ProfileState {
  final String message;
  EditFailureState(this.message);
}
