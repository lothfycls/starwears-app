import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:starwears/models/product.dart';

class SharedPreferencesService {
  Future addWatchList() async {}
  Future removeWatchList() async {}
  void upDateSharedPreferences(String email, int id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(
      'email',
      email,
    );
    _prefs.setInt('id', id);
  }

  
}
