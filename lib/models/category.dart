// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
  final int id;
  final String name;
  final String description;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });
  static List<Category> fromJson(dynamic json) {
    List<Category> categories = [];
    for (var element in json) {
      categories.add(Category(
        id: element["id"],
        name: element["name"],
        description: element["description"],
        image: element["image_url"],
      ));
    }
    return categories;
  }
}
