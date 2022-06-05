// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rental_santuy/auth.dart';
import 'package:rental_santuy/data/keys.dart';
import 'package:rental_santuy/screen/mainpage.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/style/text.dart';
import 'package:rental_santuy/widget/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rental_santuy/data/dummy_data.dart';

class Login extends StatefulWidget {
  static String nama = "", nim = "", username = "";
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
          Login.nama = DummyData.data[i][Keys.nama];
          Login.nim = DummyData.data[i][Keys.nim];
          Login.username = DummyData.data[i][Keys.username];

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
        title: TextLarge("Cuci Woy Asu"),
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
                    if (checkAccount(
                        usernameController.text, passwordController.text)) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MainPage(widget.sharedPrefs),
                          ));
                    } else {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: TextLarge("Salah"),
                              ));
                    }
                  },
                  text: "Continue with username",
                  icon: Icon(
                    Icons.sim_card,
                    color: Colors.white,
                  ),
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 24,
                ),
                ButtonRent(
                  onTap: () {
                    AuthenticationGoogle servicesGoogle =
                        AuthenticationGoogle();
                    servicesGoogle.signIn();
                  },
                  text: "Continue with Google",
                  color: MyColors.whiteSoft,
                  icon: FaIcon(FontAwesomeIcons.google),
                ),
                SizedBox(
                  height: 24,
                ),
                ButtonRent(
                  onTap: () {
                    AuthenticationServices services =
                        AuthenticationServices(FirebaseAuth.instance);
                    services
                        .signIn(
                            email: usernameController.text.trim(),
                            password: passwordController.text.trim())
                        .then((result) {
                      if (result) {
                        saveToLocal({
                          "id": 1,
                          "nama": usernameController.text.trim(),
                          "Nim": usernameController.text.trim(),
                          "username": "user1",
                          "password": "pass1",
                        }, true);
                        Navigator.pushReplacementNamed(context, "/main");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result.toString())));
                      }
                      ;
                    });
                  },
                  text: "Continue with email",
                  icon: Icon(
                    Icons.mail_outlined,
                  ),
                  color: MyColors.whiteSoft,
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/signup");
                  },
                  child: TextMedium(
                    "Don't have account yet?",
                    fontSize: 14,
                    color: MyColors.danger,
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
