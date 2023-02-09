// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';
import 'package:moment_dart/moment_dart.dart';

class Listing {
  final int id;
  final String title;
  final String description;
  final String image;

  Listing({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });
  static List<Listing> fromJson(dynamic json) {
    List<Listing> brands = [];

    for (var element in json) {
      DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .parse(element["createdAt"]);
      var outDate = parseDate.difference(Moment.now());
      String outputDate = //outputFormat.format(inputDate);
          outDate.inDays.toString() + "d";
      brands.add(Listing(
        id: element["id"],
        title: element["title"],
        description: element["description"],
        image: element["image"],
      ));
    }
    return brands;
  }
}
