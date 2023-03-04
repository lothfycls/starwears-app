part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthSuccess extends AuthenticationState {
  final String email;
  final int id;

  AuthSuccess({required this.email, required this.id});
}
class AuthLoading extends AuthenticationState{}
class LoginFailed extends AuthenticationState {
  final String message;

  LoginFailed(this.message);
}

class CreationFailed extends AuthenticationState {
  final String message;

  CreationFailed(this.message);
}
