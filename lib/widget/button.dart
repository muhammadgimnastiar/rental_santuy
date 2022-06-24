import 'package:flutter/material.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/style/text.dart';

class ButtonRent extends StatelessWidget {
  const ButtonRent({
    Key? key,
    this.color = MyColors.orangeSld,
    required this.onTap,
    required this.text,
    this.icon,
    this.textColor = Colors.black,
  }) : super(key: key);

  final String text;
  final Color color;
  final Color textColor;
  final Widget? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon ?? const TextLarge(""),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Center(
                  child: TextLargeBold(
                    text,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
