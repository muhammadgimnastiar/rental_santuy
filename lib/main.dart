import 'package:flutter/material.dart';
import 'package:rental_santuy/screen/cars.dart';

void main() {
  runApp(const MyApp());
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
        "/homescreen": (_) => const HomePage(),
        "/kendaraan": (_) => const Kendaraan(),
      },
      home: const Kendaraan(),
    );
  }
}





class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(),
    );
  }
}
