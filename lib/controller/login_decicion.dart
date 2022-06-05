import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_santuy/screen/homepage.dart';
import 'package:rental_santuy/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDecicion extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  const LoginDecicion(this.sharedPreferences, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              debugPrint("Masuk akun lewat email");
              return HomePage(sharedPreferences);
            } else {
              return Login(sharedPreferences);
            }
          }),
    );
  }
}
