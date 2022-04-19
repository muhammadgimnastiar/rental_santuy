import 'package:flutter/material.dart';
import 'package:rental_santuy/data/dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/detail.dart';
import '../style/colors.dart';
import '../style/text.dart';

class CardRental extends StatefulWidget {
  const CardRental(
    this.type,
    this.harga, {
    this.color = MyColors.blueSld,
    this.image = "",
    this.uid = 0,
    Key? key,
  }) : super(key: key);

  final String type;
  final Color color;
  final String image;
  final int harga;
  final int uid;

  @override
  State<CardRental> createState() => _CardRentalState();
}

class _CardRentalState extends State<CardRental> {
  bool isFavorite = false;
  saveToLocal() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isFavorite${widget.uid}', isFavorite);
  }

  getLocalFavorite() async {
    final pref = await SharedPreferences.getInstance();
    isFavorite = pref.getBool('isFavorite${widget.uid}') ?? false;
  }

  @override
  void initState() {
    getLocalFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        onTap: () async {
          final bool getIsFavorite = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Detail(
                        title: widget.type,
                        type: widget.type,
                        image: widget.image,
                        harga: widget.harga,
                        color: widget.color,
                        isFavorite: isFavorite,
                      )));

          if (getIsFavorite != null) {
            setState(() {
              isFavorite = getIsFavorite;
            });
          }
        },
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              width: double.maxFinite,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.color,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextLarge(
                      widget.type,
                      color: Colors.white,
                    ),
                    TextMedium(
                      "Rp ${widget.harga}k/ hari",
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        isFavorite = !isFavorite;
                        saveToLocal();

                        setState(() {});
                      },
                      child: Icon(
                        (isFavorite ? Icons.star : Icons.star_border),
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Image.asset(
              (widget.image != "")
                  ? widget.image
                  : 'lib/assets/kendaraan/electric.png',
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
