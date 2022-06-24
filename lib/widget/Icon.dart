import 'package:flutter/material.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:rental_santuy/style/text.dart';

class IconCategories extends StatelessWidget {
  final Color color;
  final String image;
  final String label;
  final Function()? onTap;
  const IconCategories(
    this.image, {
    this.color = MyColors.whiteSoft,
    this.onTap,
    this.label = "label",
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              image,
              height: 52,
            ),
          ),
          TextMedium(label),
        ],
      ),
    );
  }
}
