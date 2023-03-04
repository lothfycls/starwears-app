import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starwears/bloc/authentication_bloc.dart';
import 'package:starwears/services/auth_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AuthService authService = AuthService();
  AuthenticationBloc authenticationBloc;
  ProfileBloc({required this.authenticationBloc}) : super(ProfileInitial()) {
    on<UpdateProfile>((event, emit) async {
      try {
        bool first = event.firstName == authenticationBloc.firstName;
        bool second = event.lastName == authenticationBloc.lastName;
        bool third = event.address == authenticationBloc.homeAdress;
        bool fourth = event.phone == authenticationBloc.phoneNumber;
        bool fifth = event.username == authenticationBloc.username;
        if(!first || !second || !third || !fourth || !fifth){
        await authService.updateProfile(
            event.firstName,
            event.lastName,
            event.address,
            event.phone,
            event.username,
            authenticationBloc.userId!);
        authenticationBloc.firstName = event.firstName;
        authenticationBloc.lastName = event.lastName;
        authenticationBloc.homeAdress = event.address;
        authenticationBloc.phoneNumber = event.phone;
        authenticationBloc.username = event.username;
        emit(UpdateSuccess());
        }
        
      } catch (e) {
        emit(UpdateFailed(e.toString().substring(10)));
      }
    });
    on<UpdatePassword>((event, emit) async {
      try {
        await authService.updatePass(
            event.old, event.newPass, authenticationBloc.userId!);
        emit(PasswordSuccess());
      } catch (e) {
        emit(PasswordFailed(e.toString().substring(10)));
      }
    });
    on<UpdateUsername>((event, emit) async {
      try {
        await authService.updateUsername(
            event.username, authenticationBloc.userId!);
        authenticationBloc.username = event.username;
        emit(UsernameSuccess());
      } catch (e) {
        emit(UsernameFailed(e.toString().substring(10)));
      }
    });

    on<UpdateEmail>((event, emit) async {
      try {
        await authService.updateEmail(event.email, authenticationBloc.userId!);
        authenticationBloc.email = event.email;
        emit(EmailSuccess());
      } catch (e) {
        emit(EmailFailed(e.toString().substring(11)));
      }
    });
    on<InitProfile>(
      (event, emit) => emit(ProfileInitial()),
    );
  }
}
