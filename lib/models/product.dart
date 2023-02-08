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
  final String lastBidder;
  final String closure;
  final String department;
  final String size;
  final String color;
  final String brandName;
  final String interior_color;
  final String interior_material;
  final String material;
  final String ownerName;

  final List<String> images;
  final String auctionEnd;
  Product({
    required this.color,
    required this.interior_color,
    required this.interior_material,
    required this.id,
    required this.material,
    required this.name,
    required this.images,
    required this.department,
    required this.size,
    required this.lastBidder,
    required this.description,
    required this.condition,
    required this.ownerName,
    required this.state,
    required this.closure,
    required this.brandName,
    required this.views,
    required this.auctionEnd,
    required this.lastPrice,
  });
  static List<Product> fromJson(dynamic json) {
    List<Product> products = [];
    List<String> images = [];
    for (Map<String, dynamic> element in json) {
      for (var picture in element["productImages"]) {
        images.add(picture["url"]);
      }
      DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .parse(element["auctionEnd"]);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
      String outputDate = outputFormat.format(inputDate);

      products.add(Product(
          color: element.containsKey("Color") ? element["Color"]?? element["Color"] : "None",
          interior_color: element.containsKey("Interior_Color") ? element["Interior_Color"] ?? "none"
              : "none",
          brandName:
              element.containsKey("brand") ? element["brand"]!= null ?element["brand"]["name"]: "None":"None",
          interior_material: element.containsKey("Interior_Material")
              ? element["Interior_Material"]?? "None"
              : "none",
          id: element["id"],
          lastBidder: element.containsKey("LastBidder")
              ? element["LastBidder"] ?? "None"
              : "No Bidder yet",
          name: element["name"],
          closure: element.containsKey("closure") ? element["closure"]??"None": "None",
          ownerName:
              element.containsKey("owner") ? element["owner"]!= null ?element["owner"]["name"]:"None" : "None",
          description: element["description"],
          images: images,
          material:
              element.containsKey("Material") ? element["Material"]??"none" : "None",
          size: element.containsKey("Size") ? element["Size"]??"none" : "None",
          department: element.containsKey("department")
              ? element["department"]??"None"
              : "None",
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
