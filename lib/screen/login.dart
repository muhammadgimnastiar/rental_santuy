// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rental_santuy/data/keys.dart';
import 'package:rental_santuy/screen/cars.dart';
import 'package:rental_santuy/style/text.dart';
import 'package:rental_santuy/widget/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rental_santuy/data/dummy_data.dart';

class Login extends StatefulWidget {
  static String nama = "";
  final SharedPreferences sharedPrefs;
  const Login(this.sharedPrefs, {Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool? isLogin;
  String? usernameData;
  String? namaData;

  void saveToLocal(Map<String, dynamic> dataFound, bool isFound) async {
    await widget.sharedPrefs.setBool(Keys.login, isFound);
    await widget.sharedPrefs
        .setString(Keys.username, dataFound[Keys.username] ?? "");
    await widget.sharedPrefs.setString(Keys.nama, dataFound[Keys.nama] ?? "");
    getDataFromLocal();
  }

  void getDataFromLocal() async {
    isLogin = widget.sharedPrefs.getBool(Keys.login);
    usernameData = widget.sharedPrefs.getString(Keys.username);
    namaData = widget.sharedPrefs.getString(Keys.nama);
    print("get nama: ${namaData}");
    setState(() {});
  }

  bool checkAccount(String usernameInput, String passwordInput) {
    for (int i = 0; i < DummyData.data.length; i++) {
      if (usernameInput == DummyData.data[i][Keys.username]) {
        if (passwordInput == DummyData.data[i]['password']) {
          saveToLocal(DummyData.data[i], true);
          Login.nama = DummyData.data[i][Keys.nama];
          // setGlobalNama(DummyData.data[i][Keys.nama]);
          print("Data found ${DummyData.data[i][Keys.nama]} ${namaData}");
          return isLogin = true;
        }
      }
    }
    return isLogin = false;
  }

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: TextLarge("Rental Santuy")),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Username",
                  prefixIcon: Icon(Icons.person),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                )),
            SizedBox(
              height: 24,
            ),
            TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Username",
                  prefixIcon: Icon(Icons.lock),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                )),
            Spacer(),
            ButtonRent(
              onTap: () {
                if (checkAccount(
                    usernameController.text, passwordController.text)) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Kendaraan(widget.sharedPrefs),
                      ));
                } else {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: TextLarge("Salah"),
                          ));
                }
              },
              text: "Login",
              textColor: Colors.white,
            ),
          ],
        ),
      )),
    );
  }
}
