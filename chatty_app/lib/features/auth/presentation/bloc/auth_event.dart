part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  final String username;
  final String email;
  final String password;

  AuthSignUp({
    required this.username,
    required this.email,
    required this.password,
  });
}
