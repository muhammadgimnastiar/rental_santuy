import 'package:flutter/material.dart';
import 'package:rental_santuy/data/keys.dart';
import 'package:rental_santuy/screen/cars.dart';
import 'package:rental_santuy/screen/login.dart';
import 'package:rental_santuy/controller/login_controller.dart' as login;
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
      initialRoute: isLogin == false ? '/' : '/kendaraan',
      routes: {
        "/": (context) => Login(sharedPrefs),
        "/kendaraan": (context) => Kendaraan(sharedPrefs),
      },
    );
  }
}
