import '../models/banner.dart';
import '../models/brand.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/listing.dart';

class BannersService {
  final String url = "https://lobster-app-vpw8u.ondigitalocean.app";
  final String upcoming = "/product/upcoming/findall";
  final String banners = "/banner/findall";
  Future getBanners() async {
    final response = await http.get(Uri.parse(url + upcoming));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Banner.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }

  Future getNewListings() async {
    final response = await http.get(Uri.parse(url + banners));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Listing.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }
}
