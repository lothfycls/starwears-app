import 'dart:convert';

import 'package:starwears/models/celebrity.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductsService {
  final String url = "https://lobster-app-vpw8u.ondigitalocean.app";
  final String recoverUrl = "";
  final String celebrityEndpoint = "/celebrity/findproduct/bycelebrity/";
  final String categoryEndpoint = "/category/findproduct/bycategory/";
  final String brandEndpoint = "/brand/findbyid/products/";
  Future getCategoryProduct(int id) async {
    final String uri = url + categoryEndpoint + id.toString();
    print(uri);
    final response = await http.get(Uri.parse(uri));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Product.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }

  Future getCelebrityProducts(int id) async {
    final response =
        await http.get(Uri.parse(url + celebrityEndpoint + id.toString()));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("worked");
      return Product.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }

  Future getBrandProducts(int id) async {
    final response =
        await http.get(Uri.parse(url + brandEndpoint + id.toString()));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("worked");
      return Product.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }
}
