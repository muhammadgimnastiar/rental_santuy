import 'package:flutter/material.dart';
import 'package:rental_santuy/data/cars_data.dart' as cars;
import 'package:rental_santuy/data/keys.dart';
import 'package:rental_santuy/main.dart';
import 'package:rental_santuy/screen/login.dart';
import 'package:rental_santuy/style/text.dart';
import 'package:rental_santuy/widget/card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Kendaraan extends StatefulWidget {
  final SharedPreferences sharedPrefs;
  const Kendaraan(this.sharedPrefs, {Key? key}) : super(key: key);

  @override
  State<Kendaraan> createState() => _KendaraanState();
}

class _KendaraanState extends State<Kendaraan> {
  String title = "Cars";
  bool isFavorite = true;
  String nama = "";

  void getNamaFromLocal() async {
    nama = widget.sharedPrefs.getString(Keys.nama) ?? "null";
    setState(() {});
  }

  @override
  void initState() {
    getNamaFromLocal();
    super.initState();
  }

  List<Map<String, dynamic>> carsList = cars.CarsData.Cars;
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
              widget.sharedPrefs.clear();
              Navigator.popAndPushNamed(context, "/");
              main();
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
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TextMedium("Hello,"),
                  TextLarge(nama),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: carsList.length,
                itemBuilder: (context, index) {
                  return CardRental(
                    carsList[index]['name'],
                    carsList[index]['price'],
                    widget.sharedPrefs,
                    uid: carsList[index]['uid'],
                    image: carsList[index]['image'],
                    color: carsList[index]['color'],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
