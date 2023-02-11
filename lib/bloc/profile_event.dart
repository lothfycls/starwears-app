part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}
class UpdateUsername extends ProfileEvent {
  final String username;
  UpdateUsername({
    required this.username,
  });
}

class UpdateEmail extends ProfileEvent {
  final String email;

  UpdateEmail({required this.email});
}

class UpdatePassword extends ProfileEvent {
  final String old;
  final String newPass;

  UpdatePassword({required this.old, required this.newPass});
}
class InitProfile extends ProfileEvent{}