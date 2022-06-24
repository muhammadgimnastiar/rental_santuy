// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_santuy/auth.dart';
import 'package:rental_santuy/data/keys.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/style/text.dart';
import 'package:rental_santuy/widget/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rental_santuy/data/dummy_data.dart';

class Signup extends StatefulWidget {
  static String nama = "", nim = "", username = "";
  final SharedPreferences sharedPrefs;
  const Signup(this.sharedPrefs, {Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool? isLogin;
  String? usernameData;
  String? namaData;

  void saveToLocal(Map<String, dynamic> dataFound, bool isFound) async {
    await widget.sharedPrefs.setBool(Keys.login, isFound);
    await widget.sharedPrefs
        .setString(Keys.username, dataFound[Keys.username] ?? "");
    await widget.sharedPrefs.setString(Keys.nama, dataFound[Keys.nama] ?? "");
    getDataFromLocal();
    await widget.sharedPrefs.setString(Keys.nim, dataFound[Keys.nim] ?? "");
    getDataFromLocal();
  }

  void getDataFromLocal() async {
    isLogin = widget.sharedPrefs.getBool(Keys.login);
    usernameData = widget.sharedPrefs.getString(Keys.username);
    namaData = widget.sharedPrefs.getString(Keys.nama);
    setState(() {});
  }

  bool checkAccount(String usernameInput, String passwordInput) {
    for (int i = 0; i < DummyData.data.length; i++) {
      if (usernameInput == DummyData.data[i][Keys.username]) {
        if (passwordInput == DummyData.data[i]['password']) {
          saveToLocal(DummyData.data[i], true);
          Signup.nama = DummyData.data[i][Keys.nama];
          Signup.nim = DummyData.data[i][Keys.nim];
          Signup.username = DummyData.data[i][Keys.username];

          return isLogin = true;
        }
      }
    }
    return isLogin = false;
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: TextLarge("Rental Santuy"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Column(
              children: [
                Image.asset(
                  'lib/assets/kendaraan/intro.png',
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                const Divider(
                  height: 30,
                ),
                TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Username or email",
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
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    )),
                SizedBox(height: 32),
                ButtonRent(
                  onTap: () {
                    AuthenticationServices services =
                        AuthenticationServices(FirebaseAuth.instance);
                    services
                        .signUp(
                            email: usernameController.text.trim(),
                            password: passwordController.text.trim())
                        .then((result) {
                      if (result) {
                        saveToLocal({
                          "id": 16,
                          "nama": usernameController.text.trim(),
                          "Nim": usernameController.text.trim(),
                          "username": "user16",
                          "password": "pass16",
                        }, true);
                        Navigator.pushReplacementNamed(context, "/main");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result.toString())));
                      }
                      ;
                    });
                  },
                  text: "Daftar",
                  textColor: MyColors.whiteSoft,
                  icon: Icon(
                    Icons.input_rounded,
                    color: MyColors.whiteSoft,
                  ),
                  color: MyColors.orangeSld,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
