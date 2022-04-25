import 'package:flutter/material.dart';
import 'package:rental_santuy/screen/cars.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/style/text.dart';
import 'package:rental_santuy/widget/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
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
              onTap: () {},
              text: "Login",
              textColor: Colors.white,
            ),
          ),
        ],
      )),
    );
  }
}
