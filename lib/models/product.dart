// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';
import 'package:moment_dart/moment_dart.dart';

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
  final int ownerId;
  final int bidsCount;
  final String brandName;
  final String interior_color;
  final String interior_material;
  final String material;
  final String ownerName;

  final List<String> images;
  final String auctionEnd;
  Product({
    required this.color,
    required this.bidsCount,
    required this.interior_color,
    required this.ownerId,
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
      Duration parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .parse(element["auctionEnd"])
          .difference(DateTime.now());
      int hours = parseDate.inHours - parseDate.inDays * 24;
      String outputDate = "";
      if (parseDate.inHours == 0) {
        outputDate = "${hours}h";
      } else {
        outputDate = "${parseDate.inDays}d ${hours}h";
      }
      products.add(Product(
          ownerId: element["ownerId"],
          bidsCount: element.containsKey("_count")
              ? element["_count"] != null
                  ? element["_count"]["bids"]
                  : 0
              : 0,
          color: element.containsKey("Color")
              ? element["Color"] != null
                  ? element["Color"]
                  : "None"
              : "None",
          interior_color: element.containsKey("Interior_Color")
              ? element["Interior_Color"] != null
                  ? element["Interior_Color"]
                  : "none"
              : "none",
          brandName: element.containsKey("brand")
              ? element["brand"] != null
                  ? element["brand"]["name"]
                  : "None"
              : "None",
          interior_material: element.containsKey("Interior_Material")
              ? element["Interior_Material"] != null
                  ? element["Interior_Material"]
                  : "None"
              : "none",
          id: element["id"],
          lastBidder: element.containsKey("LastBidder")
              ? element["LastBidder"] != null
                  ? element["LastBidder"]["username"] != null
                      ? element["LastBidder"]["username"]
                      : "No bidder yet"
                  : "No Bidder yet"
              : "No Bidder yet",
          name: element["name"],
          closure: element.containsKey("closure")
              ? element["closure"] != null
                  ? element["closure"]
                  : "None"
              : "None",
          ownerName: element.containsKey("owner")
              ? element["owner"] != null
                  ? element["owner"]["name"]
                  : "None"
              : "None",
          description: element["description"],
          images: images,
          material: element.containsKey("Material")
              ? element["Material"] ?? "none"
              : "None",
          size:
              element.containsKey("Size") ? element["Size"] ?? "none" : "None",
          department: element.containsKey("department")
              ? element["department"] ?? "None"
              : "None",
          auctionEnd: outputDate,
          state: element["state"],
          views: element["views"],
          lastPrice: element["lastPrice"].toInt(),
          condition: element["condition"]));
    }
    print("single");

    print("added worked");
    return products;
  }

  static Product fromjJson(dynamic json) {
    var element = json;
    List<String> images = [];
    for (var picture in element["productImages"]) {
      images.add(picture["url"]);
    }

    Duration parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(element["auctionEnd"])
        .difference(DateTime.now());
    int hours = parseDate.inHours - parseDate.inDays * 24;
    String outputDate = "";
    if (parseDate.inHours == 0) {
      outputDate = "${hours}h";
    } else {
      outputDate = "${parseDate.inDays}d ${hours}h";
    }
    return Product(
        ownerId: element["ownerId"],
        bidsCount: element["_count"]["bids"],
        color: element.containsKey("Color")
            ? element["Color"] != null
                ? element["Color"]
                : "None"
            : "None",
        interior_color: element.containsKey("Interior_Color")
            ? element["Interior_Color"] != null
                ? element["Interior_Color"]
                : "none"
            : "none",
        brandName: element.containsKey("brand")
            ? element["brand"] != null
                ? element["brand"]["name"]
                : "None"
            : "None",
        interior_material: element.containsKey("Interior_Material")
            ? element["Interior_Material"] != null
                ? element["Interior_Material"]
                : "None"
            : "none",
        id: element["id"],
        lastBidder: element.containsKey("LastBidder")
            ? element["LastBidder"] != null
                ? element["LastBidder"]["username"] != null
                    ? element["LastBidder"]["username"]
                    : "No bidder yet"
                : "No Bidder yet"
            : "No Bidder yet",
        name: element["name"],
        closure: element.containsKey("closure")
            ? element["closure"] != null
                ? element["closure"]
                : "None"
            : "None",
        ownerName: element.containsKey("owner")
            ? element["owner"] != null
                ? element["owner"]["name"]
                : "None"
            : "None",
        description: element["description"],
        images: images,
        material: element.containsKey("Material")
            ? element["Material"] ?? "none"
            : "None",
        size: element.containsKey("Size") ? element["Size"] ?? "none" : "None",
        department: element.containsKey("department")
            ? element["department"] ?? "None"
            : "None",
        auctionEnd: outputDate,
        state: element["state"],
        views: element["views"],
        lastPrice: element["lastPrice"].toInt(),
        condition: element["condition"]);
  }

  static List<Product> fromShared(dynamic json) {
    List<Product> products = [];

    for (Map<String, dynamic> element in json) {
      products.add(Product(
          ownerId: -50,
          bidsCount: element["bidCount"],
          color: "",
          interior_color: "",
          brandName: "",
          interior_material: "",
          id: element["productId"],
          lastBidder: "",
          name: element["name"],
          closure: "",
          ownerName: "",
          description: element["description"],
          images: [element["url"]],
          material: "",
          size: "",
          department: "",
          auctionEnd: element["date"],
          state: element["state"],
          views: 0,
          lastPrice: element["price"].toInt(),
          condition: ""));
    }
    return products;
  }
}
