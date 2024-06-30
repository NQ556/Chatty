part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignUpEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;

  SignUpEvent({
    required this.username,
    required this.email,
    required this.password,
  });
}

final class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({
    required this.email,
    required this.password,
  });
}

final class ResetPasswordEvent extends AuthEvent {
  final String email;

  ResetPasswordEvent({
    required this.email,
  });
}

final class GetCurrentUserDataEvent extends AuthEvent {}

final class SignOutEvent extends AuthEvent {}
