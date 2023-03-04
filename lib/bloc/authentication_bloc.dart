import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:starwears/services/auth_service.dart';
import 'package:starwears/models/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService authService = AuthService();
  int? userId;
  String? email;
  String firstName = "";
  String lastName = "";
  String phoneNumber = "";
  String homeAdress = "";
  String username = "";
  AuthenticationBloc() : super(AuthenticationInitial()) {
    print(state);
    on<InitAuth>((event, emit) async {
      emit(AuthLoading());
      emit(AuthenticationInitial());
    });
    on<CreateUser>((event, emit) async {
      try {
        emit(AuthLoading());
        Map<String, dynamic> data = await authService.signUp(event.user);
        userId = data["id"];
        email = data["email"];
        emit(AuthSuccess(email: email!, id: userId!));
      } catch (e) {
        emit(CreationFailed(e.toString().substring(10)));
      }
    });
    on<LoginUser>((event, emit) async {
      try {
        emit(AuthLoading());
        Map<String, dynamic> data = await authService.login(event.user);
        userId = data["id"];
        email = data["email"];
        print(userId);
        emit(AuthSuccess(email: email!, id: userId!));
      } catch (e) {
        if (e.toString() == "user not found") {
          emit(LoginFailed("User with this email doesn't exist yet"));
        } else {
          emit(LoginFailed("Your password is incorrect"));
        }
      }
    });
    on<LocalAuth>((event, emit) async {
      try {
        emit(AuthLoading());
        userId = event.id;
        email = event.email;
        firstName = event.firstName;
        lastName = event.lastName;
        phoneNumber = event.phone;
        homeAdress = event.address;
        username = event.username;
        print(userId);
        emit(AuthSuccess(email: email!, id: userId!));
      } catch (e) {
        emit(LoginFailed(e.toString().substring(10)));
      }
    });
  }
}
