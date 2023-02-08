class Bid {
  final int id;
  final int amount;
  final int productId;
  Bid({
    required this.id,
    required this.amount,
    required this.productId,
  });
  static List<Bid> fromJson(dynamic json) {
    List<Bid> bids = [];
    for (var element in json) {
      bids.add(Bid(
        amount: element["amount"],
        id: element["clien_id"],
        productId: element["product_id"],
      ));
    }
    return bids;
  }
}
