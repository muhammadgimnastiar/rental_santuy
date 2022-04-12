import 'package:flutter/material.dart';

import '../screen/detail_n_order.dart';
import '../style/colors.dart';
import '../style/text.dart';

class CardRental extends StatefulWidget {
  const CardRental(
    this.type,
    this.harga, {
    this.color = MyColors.blueSld,
    this.image = "",
    Key? key,
  }) : super(key: key);

  final String type;
  final Color color;
  final String image;
  final int harga;

  @override
  State<CardRental> createState() => _CardRentalState();
}

class _CardRentalState extends State<CardRental> {
  bool isFavorite = false;
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
                        setState(() {
                          isFavorite = !isFavorite;
                        });
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
