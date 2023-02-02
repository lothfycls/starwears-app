import 'dart:convert';

import 'package:starwears/models/celebrity.dart';
import 'package:http/http.dart' as http;

class CelebritiesService {
  final String url = "https://lobster-app-vpw8u.ondigitalocean.app";
  final String recoverUrl = "";
  final String getAllCelebritiesEndpoint = "/celebrity/findall";

  Future getCelebrities() async {
    final response = await http.get(Uri.parse(url + getAllCelebritiesEndpoint));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("worked");
      return Celebrity.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }
}
