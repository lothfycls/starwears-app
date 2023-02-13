import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/notifications.dart';

class NotificationsService {
  final String url = "https://lobster-app-vpw8u.ondigitalocean.app";
  final String endpoint = "/notifications/user/findall/";
  Future getNotifications(int id) async {
    final response = await http.get(Uri.parse(url + endpoint + id.toString()));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Notifications.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }
}
