import 'package:flutter/material.dart';
import 'package:rental_santuy/screen/homepage.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  final SharedPreferences sharedPrefs;
  const MainPage(this.sharedPrefs, {Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  void _setScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> screeen = ["/home", "/Transaksi", "/Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(widget.sharedPrefs),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
          onTap: _setScreen,
          currentIndex: _selectedIndex,
          selectedItemColor: MyColors.blueSoft2,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_mini), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "Profile"),
          ]),
    );
  }
}
