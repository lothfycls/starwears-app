// ignore_for_file: public_member_api_docs, sort_constructors_first
class Celebrity {
  final int id;
  final String name;
  final String description;
  final String profession;
  final List<String> pictures;
  final int itemsCount;
  final int activeCount;
  Celebrity({
    required this.id,
    required this.name,
    required this.pictures,
    required this.itemsCount,
    required this.activeCount,
    required this.profession,
    required this.description,
  });
  static List<Celebrity> fromJson(dynamic json) {
    List<Celebrity> celebrities = [];
    List<String> pictureUrls = [];
    for (var element in json) {
      for (var picture in element["urlPictures"]) {
        pictureUrls.add(picture["url"]);
      }
      print("lhegt");

      var products = element["products"];
      celebrities.add(Celebrity(
          id: element["id"],
          name: element["name"],
          itemsCount: element["_count"]["products"],
          activeCount: products.length,
          description: element["description"],
          pictures: pictureUrls,
          profession: element["profession"]));
    }
    return celebrities;
  }
}
