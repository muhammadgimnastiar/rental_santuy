import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_santuy/services/order_service.dart';
import 'package:rental_santuy/style/text.dart';

import '../style/colors.dart';
import '../widget/transaksi_card.dart';

class DetailTransaksi extends StatefulWidget {
  const DetailTransaksi({Key? key}) : super(key: key);

  @override
  State<DetailTransaksi> createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                //appbar
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: MyColors.greySld)),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: MyColors.greySld,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: TextLargeBold(
                          "Detail Orderan",
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
                  margin: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[100]),
                  child:
                      Consumer<OrderService>(builder: ((context, order, child) {
                    List<Map<String, dynamic>> items = order.transaksi;
                    int index = order.selectedIndex!;
                    Map<String, dynamic> vehicle = items[index]['vehicle'];
                    Map<String, dynamic> wash = items[index]['wash'];
                    String totalHarga =
                        (vehicle['harga'] * vehicle['total'] + wash['harga'])
                            .toString();
                    return SizedBox(
                      height: 300,
                      child: TransaksiCard(
                          vehicle['type'],
                          wash['type'],
                          vehicle['total'].toString(),
                          totalHarga,
                          items[index]['status'],
                          order.img[vehicle['type']]!,
                          () {}),
                    );
                  })),
                ),
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 70,
        decoration: const BoxDecoration(
            color: MyColors.redSoft,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Consumer<OrderService>(
          builder: ((context, order, child) =>
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(
                    onTap: (() {
                      order.deleteTransaksi(order.selectedIndex!);
                      Navigator.pop(context);
                    }),
                    child: TextLarge("Batalkan")),
                GestureDetector(
                    onTap: (() {
                      order.updateStastusTransaksi(
                          order.selectedIndex!, "Berhasi");
                      Navigator.pop(context);
                    }),
                    child: ButtonSoft("Pesansan Selesai"))
              ])),
        ),
      ),
    );
  }
}

class ButtonSoft extends StatelessWidget {
  const ButtonSoft(
    this.text, {
    this.color = Colors.deepOrange,
    Key? key,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      child: TextLarge(text),
    );
  }
}

class ItemButton extends StatelessWidget {
  const ItemButton({
    this.icon,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final Icon? icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.grey[300]),
          child: icon),
    );
  }
}
