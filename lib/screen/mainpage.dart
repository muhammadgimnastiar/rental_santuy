import 'package:flutter/material.dart';
import 'package:rental_santuy/data/current_user.dart';
import 'package:rental_santuy/screen/bicycles.dart';
import 'package:rental_santuy/screen/homepage.dart';
import 'package:rental_santuy/screen/profile.dart';
import 'package:rental_santuy/style/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  final SharedPreferences sharedPrefs;
  MainPage(this.sharedPrefs, {Key? key}) : super(key: key);
  late CurrentUser current = CurrentUser(sharedPrefs);
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

  late List<Widget> screeen = [
    HomePage(widget.sharedPrefs),
    Profile(widget.sharedPrefs)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screeen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
          onTap: _setScreen,
          currentIndex: _selectedIndex,
          selectedItemColor: MyColors.greySld,
          unselectedItemColor: MyColors.blueSoft2,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_mini),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }
}
