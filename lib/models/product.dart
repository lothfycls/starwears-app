// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final String state;
  final int views;
  final String condition;
  final int lastPrice;
  final List<String> images;
  final String auctionEnd;
  Product({
    required this.id,
    required this.name,
    required this.images,
    required this.description,
    required this.condition,
    required this.state,
    required this.views,
    required this.auctionEnd,
    required this.lastPrice,
  });
  static List<Product> fromJson(dynamic json) {
    List<Product> products = [];
    List<String> images = [];
    for (var element in json) {
      for (var picture in element["productImages"]) {
        images.add(picture["url"]);
      }
      DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .parse(element["auctionEnd"]);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
      String outputDate = outputFormat.format(inputDate);
      products.add(Product(
          id: element["id"],
          name: element["name"],
          description: element["description"],
          images: images,
          auctionEnd: outputDate,
          state: element["state"],
          views: element["views"],
          lastPrice: element["lastPrice"],
          condition: element["condition"]));
    }
    print("added worked");
    return products;
  }
}
