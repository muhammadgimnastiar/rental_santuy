import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_santuy/services/order_service.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/widget/transaksi_card.dart';

import '../widget/transaksi_bar.dart';

class TransasksiHistory extends StatefulWidget {
  const TransasksiHistory({Key? key}) : super(key: key);

  @override
  State<TransasksiHistory> createState() => _TransasksiHistoryState();
}

class _TransasksiHistoryState extends State<TransasksiHistory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: MyColors.whiteSoft,
      child: Column(children: [
        TransaksiBar(),
        const SizedBox(
          height: 12,
        ),
        Flexible(
          child: Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: const BoxDecoration(
                color: MyColors.whiteSoft,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
              ),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child:
                      Consumer<OrderService>(builder: ((context, order, child) {
                    List<Map<String, dynamic>> items = order.transaksi;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 210,
                      child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: ((context, i) {
                            Map<String, dynamic> vehicle = items[i]['vehicle'];
                            Map<String, dynamic> wash = items[i]['wash'];
                            String totalHarga =
                                (vehicle['harga'] * vehicle['total'] +
                                        wash['harga'])
                                    .toString();
                            return GestureDetector(
                              onTap: () {
                                order.selectedIndex = i;
                                Navigator.pushNamed(
                                    context, '/transasksidetail');
                                print(i);
                              },
                              child: TransaksiCard(
                                  vehicle['type'],
                                  wash['type'],
                                  vehicle['total'].toString(),
                                  totalHarga,
                                  items[i]['status'],
                                  order.img[vehicle['type']]!,
                                  () {}),
                            );
                          })),
                    );
                  }))),
            ),
          ),
        )
      ]),
    ));
  }
}
