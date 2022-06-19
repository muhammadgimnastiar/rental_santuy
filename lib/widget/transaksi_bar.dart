import 'package:flutter/material.dart';
import 'package:rental_santuy/style/text.dart';

class TransaksiBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Column(children: [
        Row(children: const [
          TextLargeBold(
            "Daftar Transaksi",
            size: 24,
          )
        ]),
        // ignore: prefer_const_constructors
        SizedBox(
          height: 10,
        ),
        Row(
          children: const [
            Text.rich(TextSpan(
              text: "Transaksi kamu akan muncul di sini",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            )),
            // ignore: prefer_const_constructors
          ],
        ),
      ]),
    );
  }
}
