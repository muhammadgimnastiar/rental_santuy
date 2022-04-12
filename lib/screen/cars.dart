import 'package:flutter/material.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/style/text.dart';
import 'package:rental_santuy/widget/card.dart';

class Kendaraan extends StatefulWidget {
  const Kendaraan({Key? key}) : super(key: key);

  @override
  State<Kendaraan> createState() => _KendaraanState();
}

class _KendaraanState extends State<Kendaraan> {
  String title = "Cars";
  bool isFavorite = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const Icon(
            Icons.menu,
          ),
          title: Center(child: TextLarge(title)),
          actions: [
            Image.asset(
              'lib/assets/avatars/Avatar.png',
              width: 32,
            ),
            const SizedBox(
              width: 24,
            )
          ],
        ),
        body: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            children: const [
              SizedBox(
                height: 24,
              ),
              CardRental(
                "President car",
                750,
                image: "lib/assets/kendaraan/pintuTiga.png",
                color: MyColors.cokelatSld,
              ),
              CardRental(
                "Sedan",
                200,
                color: MyColors.greySld,
                image: "lib/assets/kendaraan/sedan.png",
              ),
              CardRental(
                "Taxi",
                250,
                image: "lib/assets/kendaraan/taxi.png",
                color: MyColors.orangeSld,
              ),
              CardRental(
                "Electric Car",
                300,
                image: "lib/assets/kendaraan/electric.png",
                color: MyColors.greensSld,
              ),
            ],
          ),
        ));
  }
}
