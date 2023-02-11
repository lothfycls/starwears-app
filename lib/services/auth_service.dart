import 'package:dio/dio.dart';
import 'package:starwears/services/shared_preferences_service.dart';

import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String authUrl = "https://lobster-app-vpw8u.ondigitalocean.app";
  final String recoverUrl = "";
  final String loginEndpoint = "/auth/client/local/login";
  final String signUpEdnpoint = "/auth/client/local/signUp";
  final String update = "/users/profile/update/";
  final String pass = "/users/password/update/";
  final String emailEnd = "/users/email/update/";
  final String usernameEnd = "/users/username/update/";

  Future login(BidUser user) async {
    var data = {
      'email': user.email as String,
      'password': user.password as String,
    };
    final response =
        await http.post(Uri.parse(authUrl + loginEndpoint), body: data);
    final json = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return {
        "id": json[1] as int,
        "email": user.email,
      };
    } else {
      throw Exception(json["message"]);
    }
  }

  Future signUp(BidUser user) async {
    var data = {
      'email': user.email as String,
      'password': user.password as String,
    };

    final response =
        await http.post(Uri.parse(authUrl + signUpEdnpoint), body: data);
    final res = jsonDecode(response.body);

    if (response.statusCode == 201) {
      SharedPreferencesService shared = SharedPreferencesService();
      shared.upDateSharedPreferences(user.email, res[1] as int, "", "", "", "","");
      return {"id": res[1] as int, "email": user.email};
    } else {
      throw Exception(res["message"]);
    }
  }

  Future updateProfile(String firstName, String lastName, String homeAdress,
      String phoneNumber, String username, int id) async {
    var data = {
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": homeAdress,
      "address": phoneNumber
    };
    var userData = {"username": username};
    final response = await http.post(
        Uri.parse(authUrl + update + id.toString()),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});

    final responseSecond = await http.post(
        Uri.parse(authUrl + usernameEnd + id.toString()),
        body: jsonEncode(userData),
        headers: {'Content-Type': 'application/json'});
    var json;
    if (response.statusCode == 201) {
      SharedPreferencesService shared = SharedPreferencesService();
      shared.updateInfos(firstName, lastName, homeAdress, phoneNumber,username);
      return json;
    } else {
      json = jsonDecode(response.body);
      throw Exception(json["message"]);
    }
  }

  Future updateUsername(String username, int id) async {
    var data = {
      "username": username,
    };
    final response = await http.post(
        Uri.parse(authUrl + usernameEnd + id.toString()),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});

    var json;

    if (response.statusCode == 201) {
      SharedPreferencesService shared = SharedPreferencesService();
      //shared.updateInfos(firstName, lastName, homeAdress, phoneNumber);
      return json;
    } else {
      json = jsonDecode(response.body);
      throw Exception(json["message"]);
    }
  }

  Future updateEmail(String email, int id) async {
    var data = {
      "new_email": email,
    };
    final response = await http.post(
        Uri.parse(authUrl + emailEnd + id.toString()),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});

    var json;

    if (response.statusCode == 201) {
      SharedPreferencesService shared = SharedPreferencesService();
      //shared.updateInfos(firstName, lastName, homeAdress, phoneNumber);
      return json;
    } else {
      json = jsonDecode(response.body);
      throw Exception(json["message"]);
    }
  }

  Future updatePass(String old, String newPass, int id) async {
    var data = {"old_password": old, "new_password": newPass};
    final response = await http.post(Uri.parse(authUrl + pass + id.toString()),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    var json;

    if (response.statusCode == 201) {
      SharedPreferencesService shared = SharedPreferencesService();
      //shared.updateInfos(firstName, lastName, homeAdress, phoneNumber);
      return json;
    } else {
      json = jsonDecode(response.body);
      throw Exception(json["message"]);
    }
  }

  Future signOut() async {}
}
