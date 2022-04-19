import 'package:flutter/material.dart';
import 'package:rental_santuy/screen/cars.dart';
import 'package:rental_santuy/screen/login.dart';
import 'package:rental_santuy/controller/login_controller.dart' as login;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  login.login.getDataFromLocal();
  var isLogin = prefs.getBool('isLogin');
  print(isLogin);
  runApp(MaterialApp(home: isLogin == null ? Login() : Kendaraan()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rental',
      initialRoute: '/',
      routes: {
        "/": (context) => const Login(),
        "/kendaraan": (context) => const Kendaraan(),
      },
      home: Kendaraan(),
    );
  }
}
