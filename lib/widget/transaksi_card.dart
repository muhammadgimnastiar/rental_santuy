import 'package:flutter/material.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/style/text.dart';

// ignore: must_be_immutable
class TransaksiCard extends StatelessWidget {
  String type = '';
  String washType = '';
  String count = '';
  String price = '';
  String status = '';
  String image = '';
  Function() onTap;

  TransaksiCard(this.type, this.washType, this.count, this.price, this.status,
      this.image, this.onTap,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        height: 190,
        width: 350,
        decoration: const BoxDecoration(
            color: MyColors.whiteSoft,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 0.9,
                  offset: Offset(0, 0.3),
                  blurStyle: BlurStyle.normal),
              BoxShadow(
                  spreadRadius: 3,
                  color: MyColors.whiteSoft,
                  blurRadius: 2,
                  offset: Offset(0.1, 0.1),
                  blurStyle: BlurStyle.outer)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //baris pertama
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.cloud_circle_rounded,
                          color: MyColors.green,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Malang",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: MyColors.blackSld,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Tempat Cuci Terdekat",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: MyColors.blackSld,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    "Hari Ini",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: MyColors.blackSld, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              //garis pembatas
              const Divider(
                thickness: 0.2,
                color: MyColors.blackSld,
              ),
              const SizedBox(
                height: 10,
              ),
              //baris2
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Image.asset(
                        image,
                        height: 40,
                        width: 40,
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cuci $type',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: MyColors.blackSld,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          TextSmall(text: '$count item'),
                          const SizedBox(
                            width: 20,
                          ),
                          TextSmall(text: '$washType wash')
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              //baris 3
              Padding(
                padding: const EdgeInsets.only(left: 55),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp $price',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: MyColors.blackSld,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: status == "progress"
                              ? MyColors.danger
                              : MyColors.greensSld),
                      child: Text(
                        '$status',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: status == 'progress'
                                ? MyColors.redSoft
                                : MyColors.blueSoft),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextSmall extends StatelessWidget {
  const TextSmall({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
          color: MyColors.blackSld, fontWeight: FontWeight.w400, fontSize: 14),
    );
  }
}

class TransaksiCardDetail extends StatelessWidget {
  String type = '';
  String washType = '';
  String count = '';
  String price = '';
  String status = '';
  String image = '';
  Function() onTap;

  TransaksiCardDetail(this.type, this.washType, this.count, this.price,
      this.status, this.image, this.onTap,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        height: 190,
        width: 350,
        decoration: const BoxDecoration(
            color: MyColors.whiteSoft,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 0.9,
                  offset: Offset(0, 0.3),
                  blurStyle: BlurStyle.normal),
              BoxShadow(
                  spreadRadius: 3,
                  color: MyColors.whiteSoft,
                  blurRadius: 2,
                  offset: Offset(0.1, 0.1),
                  blurStyle: BlurStyle.outer)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //baris pertama
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.cloud_circle_rounded,
                          color: MyColors.green,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Malang",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: MyColors.blackSld,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Tempat Cuci Terdekat",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: MyColors.blackSld,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    "Hari Ini",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: MyColors.blackSld, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              //garis pembatas
              const Divider(
                thickness: 0.2,
                color: MyColors.blackSld,
              ),
              const SizedBox(
                height: 10,
              ),
              //baris2
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Image.asset(
                        image,
                        height: 40,
                        width: 40,
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cuci $type',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: MyColors.blackSld,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          TextSmall(text: '$count item'),
                          const SizedBox(
                            width: 20,
                          ),
                          TextSmall(text: '$washType wash')
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              //baris 3
              Padding(
                padding: const EdgeInsets.only(left: 55),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp $price',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: MyColors.blackSld,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: status == "progress"
                              ? MyColors.danger
                              : MyColors.greensSld),
                      child: Text(
                        '$status',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: status == 'progress'
                                ? MyColors.redSoft
                                : MyColors.blueSoft),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
