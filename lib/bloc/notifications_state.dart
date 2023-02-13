part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}
class NotificationsReady extends NotificationsState{
  final List<Notifications> notifications;
  NotificationsReady({required this.notifications});
}
class NotificationsFailed extends NotificationsState{
  final String error;
  NotificationsFailed({required this.error});
}