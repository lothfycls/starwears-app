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
static List<Brand> fromJson(dynamic json){
  List<Brand> brands= [];
  for(var element in json){
  brands.add(
  Brand(id:element["id"],
  name:element["name"],
  image:element["image"],
));
  }
  return brands;
  
}
}
