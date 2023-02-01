
import '../models/brand.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BrandService {
  final String url = "https://lobster-app-vpw8u.ondigitalocean.app";
  final String getAllBrandsEndpoint = "/brand/findall";
 
  Future getBrands() async {
  
    final response =
        await http.get(Uri.parse(url + getAllBrandsEndpoint));
    final json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Brand.fromJson(json);
    } else {
      throw Exception(json["message"]);
    }
  }
}
