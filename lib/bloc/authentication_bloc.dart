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
  AuthenticationBloc() : super(AuthenticationInitial()) {
    print(state);
    on<InitAuth>((event, emit) async {
      emit(AuthenticationInitial());
    });
    on<CreateUser>((event, emit) async {
      try {
        Map<String, dynamic> data = await authService.signUp(event.user);
        userId = data["id"];
        email = data["email"];
        emit(AuthSuccess());
      } catch (e) {
        emit(CreationFailed(e.toString().substring(10)));
      }
    });
    on<LoginUser>((event, emit) async {
      try {
        Map<String, dynamic> data = await authService.login(event.user);
        userId = data["id"];
        email = data["email"];
        emit(AuthSuccess());
      } catch (e) {
        emit(LoginFailed(e.toString().substring(10)));
      }
    });
  }
}
