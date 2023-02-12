import 'package:intl/intl.dart';
import 'package:starwears/models/product.dart';

class Order {
  final String state;
  final int productId;
  int ownerId;
  String? creationDate;
  final String name;
  int? orderNumber;
  final int id;
  final String phone;
  String? trackingNumber;
  final String shippingAdress;
  final String clientComment;
  final String paymentWay;
  final int shippingCost;
  final int total;
  Product? product;
  set ow(int owner) => ownerId = owner;
  Order(
      {required this.state,
      required this.id,
      required this.productId,
      required this.clientComment,
      required this.paymentWay,
      this.product,
      required this.name,
      required this.phone,
      required this.shippingAdress,
      required this.shippingCost,
      required this.total,
      required this.ownerId});
  Order.detail(
      {required this.state,
      required this.id,
      required this.orderNumber,
      required this.productId,
      required this.clientComment,
      required this.paymentWay,
      required this.product,
      required this.trackingNumber,
      required this.creationDate,
      required this.name,
      required this.phone,
      required this.shippingAdress,
      required this.shippingCost,
      required this.total,
      required this.ownerId});
  static List<Order> fromJson(dynamic json) {
    List<Order> orders = [];
    for (var element in json) {
      orders.add(Order(
          id: element.containsKey("id") ? element["id"] : -20,
          state: element.containsKey("state") ? element["state"] : "",
          productId: element["productId"],
          ownerId: element["ownerId"],
          name: element["receiver_name"],
          phone: element["receiver_phone"],
          shippingAdress: element["shipping_address"],
          clientComment: element["client_comment"],
          paymentWay: element["payment_way"],
          total: element["total"],
          product: element.containsKey("product")
              ? element["product"] != null
                  ? Product.fromjJson(element["product"])
                  : null
              : null,
          shippingCost: element["shipping_cost"]));
    }
    return orders;
  }

  static Order fromDetail(dynamic json) {
    var element = json;
    DateTime parseDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(element["CreatedAt"]);

    String outputDate = "";
    outputDate = DateFormat("d MMMM y").format(parseDate);
   
    return Order.detail(
        orderNumber: element.containsKey("orderNumber")
            ? element["orderNumber"] != null
                ? element["orderNumber"]
                : -1
            : -1,
        id: element.containsKey("id") ? element["id"] : -20,
        state: element.containsKey("state") ? element["state"] : "",
        productId: element["productId"],
        trackingNumber: element.containsKey("tracking_number")
            ? element["tracking_number"]
            : null,
        creationDate: outputDate,
        ownerId: element["ownerId"],
        name: element["receiver_name"],
        phone: element["receiver_phone"],
        shippingAdress: element["shipping_address"],
        clientComment: element["client_comment"],
        paymentWay: element["payment_way"],
        total: element["total"],
        product: element.containsKey("product")
            ? element["product"] != null
                ? Product.fromjJson(element["product"])
                : null
            : null,
        shippingCost: element["shipping_cost"]);
  }
}
