import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_santuy/services/order_service.dart';
import 'package:rental_santuy/style/text.dart';

import '../style/colors.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer<OrderService>(builder: ((context, items, child) {
      Map<String, dynamic> avehicle = items.aTransaksi['vehicle'];
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
                            "Order",
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 14),
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[100]),
                      child: SizedBox(
                        height: 300,
                        child: ListView.separated(
                          itemCount: items.vehicle.length,
                          itemBuilder: (context, i) {
                            List<Map<String, dynamic>> vehicle = items.vehicle;
                            return OrderTile(
                              vehicle: vehicle[i]['type'],
                              harga: vehicle[i]['harga'].toString(),
                              image: items.img[vehicle[i]['type']],
                            );
                          },
                          separatorBuilder: (context, i) => const SizedBox(
                            height: 52,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          Positioned(
              top: height - 70,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 70,
                decoration: const BoxDecoration(
                    color: MyColors.redSoft,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextLarge(
                          "Rp. ${avehicle['harga'] * avehicle['total'] + items.aTransaksi['wash']['harga']}"),
                      ButtonSoft("Proses")
                    ]),
              ))
        ]),
      );
    }));
  }
}

class OrderTile extends StatefulWidget {
  const OrderTile({
    this.vehicle,
    this.harga,
    this.image,
    Key? key,
  }) : super(key: key);

  final String? vehicle;
  final String? harga;
  final String? image;

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderService>(
      builder: (context, order, _) => Row(
        children: [
          Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: MyColors.redSoft),
            child: Image.asset(
              widget.image ?? 'lib/assets/kendaraan/car.png',
              height: 52,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextLargeBold(
                  "Cuci ${widget.vehicle}",
                  size: 16,
                  overflow: TextOverflow.ellipsis,
                ),
                TextMedium(
                  "Rp. ${widget.harga}",
                  color: MyColors.greySld,
                ),
              ],
            ),
          ),
          ItemButton(
            icon: Icon(Icons.remove),
            onTap: () {
              order.aTransaksi['vehicle']['total'] -= 1;
              order.refresh();
            },
          ),
          TextLarge(order.aTransaksi['vehicle']['total'].toString()),
          ItemButton(
            icon: Icon(Icons.add),
            onTap: () {
              order.aTransaksi['vehicle']['type'] = '${widget.vehicle}';
              order.aTransaksi['vehicle']['harga'] =
                  order.vehicleHarga['${widget.vehicle}'];
              order.aTransaksi['vehicle']['total'] += 1;
              order.refresh();
            },
          ),
        ],
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
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
