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
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: TextLarge("Rental Santuy")),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                height: 32,
              ),
              TextLargeBold("All in one"),
              TextMedium("Find your favorite car, all in one place"),
            ],
          ),
          Image.asset("lib/assets/kendaraan/intro.png"),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: ButtonRent(
              onTap: () {
                login.login.auth("user14", "pass14");
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Kendaraan()));
              },
              text: "Login",
              textColor: Colors.white,
            ),
          ),
        ],
      )),
    );
  }
}
