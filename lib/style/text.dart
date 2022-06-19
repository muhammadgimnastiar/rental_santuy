import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  const Header(this.text, {this.color = Colors.black, Key? key})
      : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.poppins(
          color: color,
          fontSize: 38,
          fontWeight: FontWeight.w600,
        ));
  }
}

class TextLarge extends StatelessWidget {
  const TextLarge(this.text,
      {this.color = Colors.black, this.maxLines = 1, Key? key})
      : super(key: key);

  final String text;
  final Color color;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
    );
  }
}

class TextLargeBold extends StatelessWidget {
  const TextLargeBold(this.text,
      {this.color = Colors.black,
      this.size = 16,
      this.spacing = 1,
      this.maxLines = 1,
      this.overflow = TextOverflow.clip,
      Key? key})
      : super(key: key);

  final String text;
  final Color color;
  final double size;
  final double spacing;
  final int maxLines;
  final TextOverflow overflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.bold,
          letterSpacing: spacing),
    );
  }
}

class TextMedium extends StatelessWidget {
  const TextMedium(this.text,
      {this.color = Colors.black,
      this.fontSize = 16,
      this.decoration = TextDecoration.none,
      Key? key})
      : super(key: key);

  final String text;
  final Color color;
  final double fontSize;
  final TextDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
          decoration: decoration),
    );
  }
}
