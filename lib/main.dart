import 'package:flutter/material.dart';
import 'package:rental_santuy/data/keys.dart';
import 'package:rental_santuy/screen/bicycles.dart';
import 'package:rental_santuy/screen/cars.dart';
import 'package:rental_santuy/screen/login.dart';
import 'package:rental_santuy/screen/mainpage.dart';
import 'package:rental_santuy/screen/motors.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPrefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPrefs;
  const MyApp(this.sharedPrefs, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isLogin = sharedPrefs.getBool(Keys.login) ?? false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rental',
      initialRoute: isLogin == false ? '/' : '/main',
      routes: {
        "/": (context) => Login(sharedPrefs),
        "/car": (context) => Cars(sharedPrefs),
        "/main": (context) => MainPage(sharedPrefs),
        "/motors": (context) => Motors(sharedPrefs),
        "/bicycles": (context) => Bicycles(sharedPrefs),
      },
    );
  }
}
