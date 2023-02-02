// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:intl/intl.dart';

class Banner {
  final int id;
  final String title;
  final String description;
  final String image;
  final String creationDate;
  Banner({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.creationDate,
  });
  static List<Banner> fromJson(dynamic json) {
    List<Banner> brands = [];

    for (var element in json) {
      DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(element["createdAt"]);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
      String outputDate = outputFormat.format(inputDate);
      brands.add(Banner(
        id: element["id"],
        title: element["title"],
        description: element["description"],
        image: element["image"],
        creationDate:outputDate,
      ));
    }
    return brands;
  }
}
