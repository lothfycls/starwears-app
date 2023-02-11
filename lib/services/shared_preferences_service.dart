import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:starwears/models/product.dart';

class SharedPreferencesService {
  Future addWatchList() async {}
  Future removeWatchList() async {}
  void upDateSharedPreferences(
      String email,
      int id,
      String firstName,
      String lastName,
      String homeAddress,
      String phoneNumber,
      String username) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(
      'email',
      email,
    );
    _prefs.setInt('id', id);
    _prefs.setString("first_name", firstName);
    _prefs.setString("last_name", lastName);
    _prefs.setString("phone_number", phoneNumber);
    _prefs.setString("address", homeAddress);
    _prefs.setString("username", username);
  }

  void updateInfos(String firstName, String lastName, String homeAddress,
      String phoneNumber,String username) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    _prefs.setString("first_name", firstName);
    _prefs.setString("last_name", lastName);
    _prefs.setString("phone_number", phoneNumber);
    _prefs.setString("address", homeAddress);
    _prefs.setString("username", username);
  }
}
