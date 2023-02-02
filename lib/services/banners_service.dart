import '../models/banner.dart';
import '../models/brand.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BannersService {
  final String url = "https://lobster-app-vpw8u.ondigitalocean.app";
  final String getAllBrandsEndpoint = "/banner/findall";

  Future getBanners() async {
    final response = await http.get(Uri.parse(url + getAllBrandsEndpoint));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("worked");
      return Banner.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }
}
