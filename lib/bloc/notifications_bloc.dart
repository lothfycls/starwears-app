import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starwears/bloc/authentication_bloc.dart';
import 'package:starwears/services/notifications_service.dart';

import '../models/notifications.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  AuthenticationBloc authenticationBloc;
  NotificationsService notificationsService = NotificationsService();
  NotificationsBloc({required this.authenticationBloc})
      : super(NotificationsInitial()) {
    on<GetNotifications>((event, emit) async {
      try {
        final currentId = authenticationBloc.userId;
        if (currentId != null) {
          List<Notifications> notifications =
              await notificationsService.getNotifications(currentId);
          emit(NotificationsReady(notifications: notifications));
        } else {
          throw Exception("You're not logged in");
        }
      } catch (e) {
        emit(NotificationsFailed(error: e.toString()));
      }
    });
  }
}
