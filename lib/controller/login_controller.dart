import 'package:rental_santuy/data/dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginController {
  Map<String, dynamic> dataLogin = {};

  bool isLogin = false;

  String? nama;

  String? nim;

  String? username;

  void saveToLocal(Map<String, dynamic> dataLogin, bool isLogin) async {
    this.dataLogin = dataLogin;
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    await pref.setString('username', dataLogin['username']);
    await pref.setString('nama', dataLogin['nama']);
    await pref.setString('nim', dataLogin['Nim']);
    await pref.setBool('isLogin', isLogin);
    getDataFromLocal();
    print("Data disimpan ${isLogin} ${nama} ${username}");
  }

  void getDataFromLocal() async {
    final pref = await SharedPreferences.getInstance();
    isLogin = pref.getBool('isLogin') ?? false;
    username = pref.getString('username');
    nama = pref.getString('nama');
    nim = pref.getString('nim');
  }

  bool auth(String username, String password) {
    for (int i = 0; i < DummyData.data.length; i++) {
      if (username == DummyData.data[i]['username']) {
        if (password == DummyData.data[i]['password']) {
          saveToLocal(DummyData.data[i], true);
          return true;
        }
      }
    }
    isLogin = false;
    return isLogin;
  }

  bool logout() {
    isLogin = false;
    return isLogin;
  }

  void setIsLogin(isLogin) {
    this.isLogin = isLogin;
  }

  void setDataLogin(Map<String, dynamic> dataLogin) {
    this.dataLogin = dataLogin;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

LoginController login = LoginController();
