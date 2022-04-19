import 'package:flutter/material.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/style/text.dart';
import 'package:rental_santuy/widget/card.dart';
import 'package:rental_santuy/controller/login_controller.dart' as login;
import 'package:shared_preferences/shared_preferences.dart';

class Kendaraan extends StatefulWidget {
  const Kendaraan({Key? key}) : super(key: key);

  @override
  State<Kendaraan> createState() => _KendaraanState();
}

class _KendaraanState extends State<Kendaraan> {
  String title = "Cars";
  bool isFavorite = true;
  String? nama = "";

  void getNamaFromLocal() async {
    final pref = await SharedPreferences.getInstance();
    nama = pref.getString('nama');
    print("Getnama from widget cars ${pref.getString('nama')}");
    setState(() {});
  }

  @override
  void initState() {
    getNamaFromLocal();
    super.initState();
  }

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
            InkWell(
              onTap: (() async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.popAndPushNamed(context, "/");
              }),
              child: Image.asset(
                'lib/assets/avatars/Avatar.png',
                width: 32,
              ),
            ),
            const SizedBox(
              width: 24,
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextMedium("Hello,"),
                    TextLarge(login.login.nama.toString()),
                  ],
                ),
              ),
              const CardRental(
                "President car",
                750,
                image: "lib/assets/kendaraan/pintuTiga.png",
                color: MyColors.cokelatSld,
              ),
              const CardRental(
                "Sedan",
                200,
                color: MyColors.greySld,
                image: "lib/assets/kendaraan/sedan.png",
              ),
              const CardRental(
                "Taxi",
                250,
                image: "lib/assets/kendaraan/taxi.png",
                color: MyColors.orangeSld,
              ),
              const CardRental(
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
