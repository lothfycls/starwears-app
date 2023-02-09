class Order {
  final String state;
  final int productId;
  int ownerId;
  final String name;
  final String phone;
  final String shippingAdress;
  final String clientComment;
  final String paymentWay;
  final int shippingCost;
  final int total;
   set ow(int owner) => ownerId = owner;
  Order(
      {required this.state,
      required this.productId,
      required this.clientComment,
      required this.paymentWay,
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
          state: element["state"],
          productId: element["productId"],
          ownerId: element["ownerId"],
          name: element["receiver_name"],
          phone: element["receiver_phone"],
          shippingAdress: element["shipping_address"],
          clientComment: element["client_comment"],
          paymentWay: element["payment_way"],
          total: element["total"],
          shippingCost: element["shipping_cost"]));
    }
    return orders;
  }
}
