part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}
class InitAuth extends AuthenticationEvent{}
class CreateUser extends AuthenticationEvent {
  final BidUser user;

  CreateUser(this.user);
}

class LoginUser extends AuthenticationEvent {
  final BidUser user;
  LoginUser(this.user);
}
