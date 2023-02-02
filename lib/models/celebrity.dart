// ignore_for_file: public_member_api_docs, sort_constructors_first
class Celebrity {
  final int id;
  final String name;
  final String description;
  final String profession;
  final List<String> pictures;
  Celebrity(
    {
    required this.id,
    required this.name,
    required this.pictures,
    required this.profession,
    required this.description,
  });
  static List<Celebrity> fromJson(dynamic json) {
    List<Celebrity> celebrities = [];
    List<String> pictureUrls=[];
    for (var element in json) {
          for( var picture in element["urlPictures"]){
              pictureUrls.add(picture["url"]);
          }


      celebrities.add(Celebrity(
        id: element["id"],
        name: element["name"],
        description: element["description"], pictures: pictureUrls,
        profession: element["profession"]
      ));
    }
    return celebrities;
  }
}
