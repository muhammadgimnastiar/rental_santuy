import 'package:flutter/material.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/style/text.dart';

class ButtonRent extends StatelessWidget {
  const ButtonRent({
    Key? key,
    this.color = MyColors.orangeSld,
    required this.onTap,
    required this.text,
    this.textColor = Colors.black,
  }) : super(key: key);

  final String text;
  final Color color;
  final Color textColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextLargeBold(
              text,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
