import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/bid.dart';

class BidService {
  final String url = "https://lobster-app-vpw8u.ondigitalocean.app";
  final String addBidEndpoint = "/bid/create";
  final String userBid = "/bid/client/findall/";
  final String productEndpoint = "";

  Future checkProductUserState() async {}
  
  Future getUserBids(int id) async {
    final response = await http.get(Uri.parse(url + userBid + id.toString()));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("worked");
      return Bid.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }

  Future getUserRelationShipBid(int productId, int clientId) async {}
  Future addBid(Bid bid) async {
    var data = {
      "amount": bid.amount,
      "clien_id": bid.id,
      "product_id": bid.productId,
    };
    final response = await http.post(Uri.parse(url + addBidEndpoint),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    final json = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return json;
    } else {
      throw Exception(json["message"]);
    }
  }
}
