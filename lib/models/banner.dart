// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';
import 'package:moment_dart/moment_dart.dart';

class Banner {
  final int id;
  final String title;
  final String description;
  final List<String> image;
  final String auctionEnd;
  final String ownerName;
  Banner({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.ownerName,
    required this.auctionEnd,
  });
  static List<Banner> fromJson(dynamic json) {
    List<Banner> brands = [];
    List<String> images = [];

    for (var element in json) {
     DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .parse(element["auctionEnd"]);
      var outDate = parseDate.difference(Moment.now());
      String outputDate = //outputFormat.format(inputDate);
          outDate.inDays.toString() + "d";
        for (var picture in element["productImages"]) {
        images.add(picture["url"]);
      }
      print("yadra hna");
      brands.add(Banner(
        id: element["id"],
        title: element["name"],
        description: element["description"],
        image: images,
        ownerName: element["owner"]["name"],
        auctionEnd: outputDate,
      ));
    }
    return brands;
  }
}
