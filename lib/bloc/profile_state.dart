part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class PasswordFailed extends ProfileState {
  final String message;

  PasswordFailed(this.message);
}
class UpdateFailed extends PasswordFailed{
  UpdateFailed(super.message);

}
class UpdateSuccess extends ProfileState{}
class EmailFailed extends ProfileState {
  final String message;

  EmailFailed(this.message);
}class UsernameFailed extends ProfileState {
  final String message;

  UsernameFailed(this.message);
}
class PasswordSuccess extends ProfileState{}
class EmailSuccess extends ProfileState{}
class UsernameSuccess extends ProfileState{}