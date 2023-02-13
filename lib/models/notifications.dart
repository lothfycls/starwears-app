class Notifications {
  final String message;
  final String createdAt;
  final int id;
  Notifications(
      {required this.message, required this.createdAt, required this.id});
  static List<Notifications> fromJson(dynamic json) {
    List<Notifications> notifications = [];
    for (var element in json) {
      notifications.add(Notifications(
        id: element["id"],
        createdAt: element["createdAt"],
        message: element["message"],
      ));
    }
    return notifications;
  }
}
