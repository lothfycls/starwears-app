import 'package:dio/dio.dart';

import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String authUrl = "https://lobster-app-vpw8u.ondigitalocean.app";
  final String recoverUrl = "";
  final String loginEndpoint = "/auth/client/local/login";
  final String signUpEdnpoint = "/auth/client/local/signUp";
  AuthService() {
    //dio.options.contentType = 'application/json';
  }
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
      return {"id": res[1] as int, "email": user.email};
    } else {
      throw Exception(res["message"]);
    }
  }

  Future signOut() async {}
}
