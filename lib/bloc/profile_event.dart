part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}
class UpdateProfile extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String address;
  final String phone;
  final String username;
  UpdateProfile(
      {required this.firstName,
      required this.lastName,
      required this.address,
      required this.phone,
      required this.username});
}
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