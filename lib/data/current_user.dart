import 'package:flutter/material.dart';
import 'package:rental_santuy/data/keys.dart';
import 'package:rental_santuy/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUser {
  bool isFavorite = true;
  String nama = "";
  String nim = "";
  String username = "";
  final SharedPreferences sharedPreferences;
  CurrentUser(this.sharedPreferences);

  void getDataFromLocal() async {
    nama = sharedPreferences.getString(Keys.nama) ?? Login.nama;
    nim = sharedPreferences.getString(Keys.nim) ?? Login.nim;
    username = sharedPreferences.getString(Keys.username) ?? Login.username;
  }
}
