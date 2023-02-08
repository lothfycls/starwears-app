import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:starwears/models/bid.dart';
import 'package:starwears/models/celebrity.dart';
import 'package:http/http.dart' as http;
import 'package:starwears/services/bids_service.dart';
import 'package:starwears/services/celebrities_service.dart';

import '../models/product.dart';

class ProductsService {
  final String url = "https://lobster-app-vpw8u.ondigitalocean.app";
  final String recoverUrl = "";
  final String celebrityEndpoint = "/celebrity/findproduct/bycelebrity/";
  final String categoryEndpoint = "/category/findproduct/bycategory/";
  final String brandEndpoint = "/brand/findbyid/products/";
  final String trending = "/product/trends/findall";
  final String userBids = "/users/productBids/";
  final String endedEndpoint = "/product/end/findall";
  final String activeEndpoint = "/product/active/findall";
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

  Future getTrendingProducts() async {
    final response = await http.get(Uri.parse(url + trending));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("worked");

      return Product.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }

  Future getEndedProducts() async {
    final response = await http.get(Uri.parse(url + endedEndpoint));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Product.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }

  Future getActiveProducts() async {
    final response = await http.get(Uri.parse(url + activeEndpoint));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      int i = 0;
      for (Map<String, dynamic> jsonObject in json) {
     /*   int ownerId = jsonObject["ownerId"];
        CelebritiesService celebritiesService = CelebritiesService();
        List<Celebrity> celebs = await celebritiesService.getCelebrities();
        Celebrity celeb = celebs.firstWhere((element) => element.id == ownerId);
        final ownerEntry = <String, Map<String, String>>{
          "owner": {
            "name": celeb.name,
          }
        };*/
        final imageEntry = <String, dynamic>{
          "productImages": [
            {
              "url":
                  "https://www.valoisvintage-paris.com/8033-thickbox_default/dress-black-chanel-t-44.jpg"
            }
          ]
        };
        //jsonObject.addEntries(ownerEntry.entries);
        jsonObject.addEntries(imageEntry.entries);
        json[i] = jsonObject;
        i++;
      }
      return Product.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }

  Future getUserBidProducts(int id) async {
    final response = await http.get(Uri.parse(url + userBids + id.toString()));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("worked");
      return Product.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }
}
