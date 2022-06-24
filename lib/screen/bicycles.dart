import 'package:flutter/material.dart';
import 'package:rental_santuy/data/current_user.dart';
import 'package:rental_santuy/data/vehicle_data.dart' as vehicle;
import 'package:rental_santuy/data/keys.dart';
import 'package:rental_santuy/screen/login.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/style/text.dart';
import 'package:rental_santuy/widget/card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/modal.dart';

class Bicycles extends StatefulWidget {
  final SharedPreferences sharedPrefs;
  Bicycles(this.sharedPrefs, {Key? key}) : super(key: key);
  late CurrentUser user = CurrentUser(sharedPrefs);

  @override
  State<Bicycles> createState() => _BicyclesState();
}

class _BicyclesState extends State<Bicycles> {
  String title = "Bicycles";

  @override
  void initState() {
    widget.user.getDataFromLocal();

    super.initState();
  }

  List<Map<String, dynamic>> carsList = vehicle.VehicleData.Bicycles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: MyColors.blackSld,
          ),
        ),
        title: Center(child: TextLarge(title)),
        actions: [
          InkWell(
            onTap: (() async {
              showFloatingModalBottomSheet(
                context: context,
                builder: (context) => ModalFit(
                  nama: widget.user.nama,
                  nim: widget.user.nim,
                  username: widget.user.username,
                  sharedPrefs: widget.sharedPrefs,
                ),
              );
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
        child: ListView.builder(
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
      ),
    );
  }
}
