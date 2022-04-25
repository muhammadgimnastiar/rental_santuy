import 'package:rental_santuy/style/colors.dart';

class CarsData {
  static List<Map<String, dynamic>> Cars = [
    {
      'uid': 1,
      'name': "President car",
      'price': 750,
      'image': "lib/assets/kendaraan/pintuTiga.png",
      'color': MyColors.cokelatSld,
    },
    {
      'uid': 2,
      'name': "Sedan",
      'price': 200,
      'image': "lib/assets/kendaraan/sedan.png",
      'color': MyColors.greensSld,
    },
    {
      'uid': 3,
      'name': "Taxi",
      'price': 250,
      'image': "lib/assets/kendaraan/taxi.png",
      'color': MyColors.orangeSld,
    },
    {
      'uid': 4,
      'name': "Electric Car",
      'price': 300,
      'image': "lib/assets/kendaraan/electric.png",
      'color': MyColors.greensSld,
    },
  ];
}
