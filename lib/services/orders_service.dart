import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/order.dart';

class OrderService {
  final String url = "https://lobster-app-vpw8u.ondigitalocean.app";
  final String addUrl = "/order/create";
  final String updateUrl = "/order/update/state";
  final String successUrl = "/order/purchases/success";
  final String pendingUrl = "/order/purchases/pending";

  Future addOrder(Order order) async {
    var data = {
      "orderId": order.state,
      "receiver_name": order.name,
      "ownerId": order.ownerId,
      "receiver_phone": order.phone,
      "shipping_address": order.shippingAdress,
      "client_comment": order.clientComment,
      "payment_way": order.paymentWay,
      "shipping_cost": order.shippingCost,
      "total": order.total,
      // "clien_id": order.id,
      "productId": order.productId,
    };
    final response = await http.post(Uri.parse(url + addUrl),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    final json = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return json;
    } else {
      throw Exception(json["message"]);
    }
  }

  Future updateOrder(int orderId) async {
    var data = {
      "order_status": "PAID",
    };
    final response = await http.post(
        Uri.parse(url + updateUrl + "/" + orderId.toString()),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});

    final json = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return json;
    } else {
      throw Exception(json["message"]);
    }
  }

  Future getPendingOrders(int clientId) async {
    final response =
        await http.get(Uri.parse(url + pendingUrl + "/" +clientId.toString()));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Order.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }

  Future getSuccessOrders(int clientId) async {
    final response =
        await http.get(Uri.parse(url + successUrl + "/" + clientId.toString()));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Order.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }
}
