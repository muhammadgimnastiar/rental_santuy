import 'package:flutter/material.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/widget/button.dart';

import '../style/text.dart';

class Detail extends StatefulWidget {
  Detail(
      {required this.title,
      required this.image,
      required this.harga,
      required this.type,
      required this.color,
      this.isFavorite = false,
      Key? key})
      : super(key: key);

  final String title;
  final String type;
  final String image;
  final int harga;
  final Color color;
  bool isFavorite;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool isPesan = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context, widget.isFavorite);
          },
        ),
        title: Center(child: TextLarge(widget.title)),
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
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(24), child: Image.asset(widget.image)),
          Expanded(
            child: Container(
              height: double.maxFinite,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: widget.color,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Header(
                              widget.type,
                              color: Colors.white,
                            ),
                            TextMedium(
                              "Rp ${widget.harga}k/hari",
                              color: Colors.white,
                            )
                          ],
                        ),
                        InkWell(
                          onTap: (() {
                            setState(() {
                              widget.isFavorite = !widget.isFavorite;
                            });
                          }),
                          child: Icon(
                            widget.isFavorite
                                ? Icons.star
                                : Icons.star_border_outlined,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    ButtonRent(
                      text: (!isPesan) ? "Pesan" : "Batal",
                      color: (!isPesan) ? Colors.white : MyColors.danger,
                      onTap: () {
                        setState(() {
                          if (isPesan == false) {
                            showDialog(
                                context: context, builder: _buildPopupDialog);
                          }
                          isPesan = !isPesan;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const TextLarge('Berhasil dipesan'),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const TextMedium('Close'),
      ),
    ],
  );
}
