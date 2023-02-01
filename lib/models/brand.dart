// ignore_for_file: public_member_api_docs, sort_constructors_first
class Brand {
  final int id;
  final String name;
  final String image;
  Brand({
    required this.id,
    required this.name,
    required this.image,
  });
factory Brand.fromJson(Map<String,dynamic> json){
  return Brand(
    id: json["id"],
    name: json["name"],
    image : json["image"]
  );
}

}
