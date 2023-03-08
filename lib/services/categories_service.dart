import 'dart:convert';

import 'package:starwears/models/category.dart';
import 'package:http/http.dart' as http;

class CategoriesService {
  final String url = "https://lobster-app-vpw8u.ondigitalocean.app";
  final String recoverUrl = "";
  final String getAllCategoriesEndpoint = "/category/findall";
  Future getCategories() async {
    final response = await http.get(Uri.parse(url + getAllCategoriesEndpoint));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Category.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }
}
