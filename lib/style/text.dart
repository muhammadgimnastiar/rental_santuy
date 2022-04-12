import 'package:flutter/cupertino.dart';
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
  const TextLarge(this.text, {this.color = Colors.black, Key? key})
      : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
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
  const TextLargeBold(this.text, {this.color = Colors.black, Key? key})
      : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: color, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

class TextMedium extends StatelessWidget {
  const TextMedium(this.text, {this.color = Colors.black, Key? key})
      : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: color, fontSize: 16, fontWeight: FontWeight.normal),
    );
  }
}
