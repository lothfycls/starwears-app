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
