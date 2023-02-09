import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starwears/models/relationship.dart';

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
  final String singleProduct = "/product/find/";
  final String relationShip = "/users/state/product/";
  final String activeBids = "/users/bids/active/";
  final String wonBids = "/users/bids/wins/";
  final String lostBids = "/users/bids/failed/";


  Future getRelationShip(int productId, int clientId) async {
    final String uri =
        url + relationShip + productId.toString() + "/" + clientId.toString();
    print(uri);
    final response = await http.get(Uri.parse(uri));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Relationship.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }

  Future addToWatchList(Product product) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? watchlist = _prefs.getString("watchlist");
    List<dynamic> decodedList = watchlist != null ? json.decode(watchlist) : [];
    decodedList.add({
      "name": product.name,
      "productId": product.id,
      "price": product.lastPrice,
      "state": product.state,
      "bidCount": product.bidsCount,
      "date": product.auctionEnd,
      "description": product.description,
      "url": product.images[0],
    });
    _prefs.setString("watchlist", json.encode(decodedList));
  }

  Future getWatchListItems() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? watchlistString = _prefs.getString("watchlist");
    List<Product> prods = [];
    if (watchlistString != null) {
      List<dynamic> products = json.decode(watchlistString);
      prods = Product.fromShared(products);
      //return Product.fromJson(products);
    }
    return prods;
  }

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

  Future getSingleProduct(int productId) async {
    final String uri = url + singleProduct + productId.toString();
    print(uri);
    final response = await http.get(Uri.parse(uri));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Product.fromjJson(json);
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
      print("rani f trending");

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
  Future getActiveBids(int id) async {
    final response = await http.get(Uri.parse(url + activeBids + id.toString()));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("worked");
      return Product.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }
  Future getWonBids(int id) async {
    final response = await http.get(Uri.parse(url + wonBids + id.toString()));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("worked");
      return Product.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }
  Future getLostBids(int id) async {
    final response = await http.get(Uri.parse(url + lostBids + id.toString()));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("worked");
      return Product.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }
}
