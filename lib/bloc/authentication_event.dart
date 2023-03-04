// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class InitAuth extends AuthenticationEvent {}

class CreateUser extends AuthenticationEvent {
  final BidUser user;

  CreateUser(this.user);
}

class LoginUser extends AuthenticationEvent {
  final BidUser user;
  LoginUser(this.user);
}

class LocalAuth extends AuthenticationEvent {
  final String email;
  final int id;
  final String firstName;
  final String lastName;
  final String address;
  final String username;
  final String phone;

  LocalAuth(
      {required this.email,
      required this.id,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.address,
      required this.phone});
}


