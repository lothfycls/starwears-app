part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthSuccess extends AuthenticationState {}

class LoginFailed extends AuthenticationState {
  final String message;

  LoginFailed(this.message);

}

class CreationFailed extends AuthenticationState {
  final String message;

  CreationFailed(this.message);

}