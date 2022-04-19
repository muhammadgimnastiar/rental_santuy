// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rental_santuy/controller/login_controller.dart';
import 'package:rental_santuy/screen/cars.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/style/text.dart';
import 'package:rental_santuy/widget/button.dart';
import 'package:rental_santuy/controller/login_controller.dart' as login;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
            TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Username",
                  prefixIcon: Icon(Icons.person),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                )),
            Spacer(),
            ButtonRent(
              onTap: () {
                if (login.login
                    .auth(usernameController.text, passwordController.text)) {
                  print("Control user input: ${usernameController.text}");

                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => Kendaraan()));
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
